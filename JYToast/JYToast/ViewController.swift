//
//  ViewController.swift
//  JYToast
//
//  Created by 박지연 on 2017. 9. 20..
//  Copyright © 2017년 박지연. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	private var toast: JYToast!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		initUi()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
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

