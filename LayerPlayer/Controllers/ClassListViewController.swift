/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class ClassListViewController: UITableViewController {
  let classes: [ClassDescription] = [
    ClassDescription(title: "CALayer", description: "Manage and animate visual content"),
    ClassDescription(title: "CAScrollLayer", description: "Display portion of a scrollable layer"),
    ClassDescription(title: "CATextLayer", description: "Render plain text or attributed strings"),
    ClassDescription(title: "AVPlayerLayer", description: "Display an AV player"),
    ClassDescription(title: "CAGradientLayer", description: "Apply a color gradient over the background"),
    ClassDescription(title: "CAReplicatorLayer", description: "Duplicate a source layer"),
    ClassDescription(title: "CATiledLayer", description: "Asynchronously draw layer content in tiles"),
    ClassDescription(title: "CAShapeLayer", description: "Draw using scalable vector paths"),
    ClassDescription(title: "CATransformLayer", description: "Draw 3D structures"),
    ClassDescription(title: "CAEmitterLayer", description: "Render animated particles"),
  ]
}

// MARK: - UITableViewDataSource
extension ClassListViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return classes.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ClassCell", for: indexPath)
    let classDescription = classes[indexPath.row]
    cell.textLabel?.text = classDescription.title
    cell.detailTextLabel?.text = classDescription.description
    cell.imageView?.image = UIImage(named: classDescription.title)
    return cell
  }
}

// MARK: - UITableViewDelegate
extension ClassListViewController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let identifier = classes[indexPath.row].title
    performSegue(withIdentifier: identifier, sender: nil)
  }
}
