//
//  JYToast.swift
//  JYToast
//
//  Created by 박지연 on 2017. 9. 20..
//  Copyright © 2017년 박지연. All rights reserved.
//

import UIKit

class JYToast: UILabel {
	
	private let alphaMAX: CGFloat = 0.7
	private let alphaMIN: CGFloat = 0.0
	
	private var message: String = "" {
		didSet {
			if message != text && isToasting {
				text = message
				willDisappearImmediately()
				willAppear()
			} else if !isToasting {
				text = message
				willAppear()
			}
		}
	}
	
	override var text: String? {
		didSet {
			reSizing()
		}
	}
	
	private var isToasting = false
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		initUi()
	}
	
	init(message: String) {
		super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		self.message = message
		initUi()
	}
	
	init() {
		super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		
		initUi()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		initUi()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		initUi()
	}
	
	private func initUi() {
		
		self.textColor = .white
		self.font = UIFont.systemFont(ofSize: 14.0)
		self.numberOfLines = 0
		self.backgroundColor = UIColor.black
		self.textAlignment = NSTextAlignment.center
		self.alpha = alphaMIN
		self.layer.cornerRadius = 13
		self.clipsToBounds  =  true
		self.bounds.size = CGSize(width: 0, height: 0)
	}
	
	func isShow(_ message: String) {
		self.message = message
		willAppear()
	}
	
	override func drawText(in rect: CGRect) {
		let insets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
		super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
	}
	
	private func reSizing() {
		
		let size = self.getSize()
		self.bounds.size = CGSize(width: size.width + 30, height: size.height + 20)
		
		reloacateCenter()
	}
	
	override func didMoveToSuperview() {
		super.didMoveToSuperview()
		
		NotificationCenter.default.addObserver(self, selector: #selector(onDeviceOrientationDidChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
		
		reloacateCenter()
	}
	
	override func removeFromSuperview() {
		super.removeFromSuperview()
		NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
	}
	
	@objc private func onDeviceOrientationDidChange() {
		self.center = CGPoint(x: UIScreen.main.bounds.width / 2,
		                      y: UIScreen.main.bounds.height - 150)
	}
	
	private func reloacateCenter() {
		self.center = CGPoint(x: UIScreen.main.bounds.width / 2,
		                      y: UIScreen.main.bounds.height - 150)
	}
	
	private func willDisappearWithAnimation() {
		UIView.animate(withDuration: 0.5,
		               delay: 1.5,
		               options: .curveEaseOut,
		               animations: { self.alpha = 0.0 },
		               completion: {(finished:Bool) in
						self.isToasting = false
		})
	}
	
	private func willAppear() {
		
		if let window = UIApplication.shared.windows.last {
			if window.subviews.filter({ $0 is JYToast }).first == nil {
				window.addSubview(self)
				window.bringSubview(toFront: self)
			}
		}
		
		self.alpha = alphaMAX
		self.isToasting = true
		willDisappearWithAnimation()
	}
	
	private func willDisappearImmediately() {
		self.alpha = alphaMIN
		self.isToasting = false
	}
	
	private func getSize() -> CGSize {
		
		guard let string = text else {
			return CGSize(width: 0, height: 0)
		}
		
		let screenSize = UIScreen.main.bounds.size
		let constrainedSize = CGSize(width: screenSize.width - 100, height: screenSize.height - 100)
		let boundingBox = string.boundingRect(with: constrainedSize,
		                                      options: .usesLineFragmentOrigin,
		                                      attributes: [NSAttributedStringKey.font: self.font],
		                                      context: nil)
		
		return boundingBox.size
	}
}
