## JYToast
basic Toast View
coverage : ios 8.0 +

### Use

```markdown

import UIKit

class ViewController: UIViewController {

	private var toast: JYToast!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		initUi()
	}

	private func initUi() {
		toast = JYToast()
	}

	@IBAction private func onToast1DidPress(_ sender: UIButton) {
		let message = "Toast 1 is Showing"
		toast.isShow(message)
	}
	
	@IBAction private func onToast2DidPress(_ sender: UIButton) {
		let message = "Toast 2 is Showing"
		toast.isShow(message)
	}
}

```
