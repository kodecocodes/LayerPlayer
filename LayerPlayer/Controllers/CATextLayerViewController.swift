/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class CATextLayerViewController: UIViewController {
  @IBOutlet weak var viewForTextLayer: UIView!
  @IBOutlet weak var fontSizeSliderValueLabel: UILabel!
  @IBOutlet weak var fontSizeSlider: UISlider!
  @IBOutlet weak var wrapTextSwitch: UISwitch!
  @IBOutlet weak var alignmentModeSegmentedControl: UISegmentedControl!
  @IBOutlet weak var truncationModeSegmentedControl: UISegmentedControl!
  
  enum Font: Int {
    case helvetica, noteworthyLight
  }
  
  enum AlignmentMode: Int {
    case left, center, justified, right
  }
  enum TruncationMode: Int {
    case start, middle, end
  }
  
  private enum Constants {
    static let baseFontSize: CGFloat = 24.0
  }
  let noteworthyLightFont: AnyObject? = CTFontCreateWithName("Noteworthy-Light" as CFString, Constants.baseFontSize, nil)
  let helveticaFont: AnyObject? = CTFontCreateWithName("Helvetica" as CFString, Constants.baseFontSize, nil)
  let textLayer = CATextLayer()
  var fontSize: CGFloat = Constants.baseFontSize
  var previouslySelectedTruncationMode = TruncationMode.end
    
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpTextLayer()
    viewForTextLayer.layer.addSublayer(textLayer)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    textLayer.frame = viewForTextLayer.bounds
    textLayer.fontSize = fontSize
  }
}

// MARK: - Quick reference
extension CATextLayerViewController {
  func setUpTextLayer() {
    textLayer.frame = viewForTextLayer.bounds
    var string = ""
    
    for _ in 1...20 {
      string += "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce auctor arcu quis velit congue dictum. "
    }
    
    textLayer.string = string
    textLayer.font = helveticaFont
    textLayer.foregroundColor = UIColor.darkGray.cgColor
    textLayer.isWrapped = true
    textLayer.alignmentMode = .left
    textLayer.truncationMode = .end
    textLayer.contentsScale = UIScreen.main.scale
  }
}

// MARK: - IBActions
extension CATextLayerViewController {
  @IBAction func fontSegmentedControlChanged(_ sender: UISegmentedControl) {
    switch sender.selectedSegmentIndex {
    case Font.helvetica.rawValue:
      textLayer.font = helveticaFont
    case Font.noteworthyLight.rawValue:
      textLayer.font = noteworthyLightFont
    default:
      break
    }
  }
  
  @IBAction func fontSizeSliderChanged(_ sender: UISlider) {
    fontSizeSliderValueLabel.text = "\(Int(sender.value * 100.0))%"
    fontSize = Constants.baseFontSize * CGFloat(sender.value)
  }
  
  @IBAction func wrapTextSwitchChanged(_ sender: UISwitch) {
    alignmentModeSegmentedControl.selectedSegmentIndex = AlignmentMode.left.rawValue
    textLayer.alignmentMode = CATextLayerAlignmentMode.left
    
    if sender.isOn {
      if let truncationMode = TruncationMode(rawValue: truncationModeSegmentedControl.selectedSegmentIndex) {
        previouslySelectedTruncationMode = truncationMode
      }
      
      truncationModeSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
      textLayer.isWrapped = true
    } else {
      textLayer.isWrapped = false
      truncationModeSegmentedControl.selectedSegmentIndex = previouslySelectedTruncationMode.rawValue
    }
  }
  
  @IBAction func alignmentModeSegmentedControlChanged(_ sender: UISegmentedControl) {
    wrapTextSwitch.isOn = true
    textLayer.isWrapped = true
    truncationModeSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
    textLayer.truncationMode = CATextLayerTruncationMode.none
    
    switch sender.selectedSegmentIndex {
    case AlignmentMode.left.rawValue:
      textLayer.alignmentMode = .left
    case AlignmentMode.center.rawValue:
      textLayer.alignmentMode = .center
    case AlignmentMode.justified.rawValue:
      textLayer.alignmentMode = .justified
    case AlignmentMode.right.rawValue:
      textLayer.alignmentMode = .right
    default:
      textLayer.alignmentMode = .left
    }
  }
  
  @IBAction func truncationModeSegmentedControlChanged(_ sender: UISegmentedControl) {
    wrapTextSwitch.isOn = false
    textLayer.isWrapped = false
    alignmentModeSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
    textLayer.alignmentMode = .left
    
    switch sender.selectedSegmentIndex {
    case TruncationMode.start.rawValue:
      textLayer.truncationMode = .start
    case TruncationMode.middle.rawValue:
      textLayer.truncationMode = .middle
    case TruncationMode.end.rawValue:
      textLayer.truncationMode = .end
    default:
      textLayer.truncationMode = .none
    }
  }
}
