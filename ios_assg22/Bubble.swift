//
//  Bubble.swift
//  ios_assg22
//
//  Created by ヴァイオレット・エヴァーガーデン on 8/5/20.
//  Copyright © 2020 Harry. All rights reserved.
//

import Foundation

import UIKit

class Bubble: UIButton {
	var value :Int = 0
	var bArray_index :Int = -999
	
	required init?(coder aDecoder: NSCoder){
		super.init(coder: aDecoder)!
	}
	
	override init(frame: CGRect){
		super.init(frame: frame)
		
		let possibility = Int.random(in : 1...100)
		switch possibility{
		case 1...40:
			self.setImage(UIImage(named: "Pawn"), for: UIControl.State.normal)
			self.value = 1
		case 41...70:
			let K_or_B = Int.random(in: 0...1)
				if(K_or_B == 0){
					self.setImage(UIImage(named: "Knight"), for: UIControl.State.normal)
				}
				else{
					self.setImage(UIImage(named: "Bishop"), for: UIControl.State.normal)
				}
			self.value = 2
		case 71...85:
			self.setImage(UIImage(named: "Rook"), for: UIControl.State.normal)
			self.value = 5
		case 86...95:
			self.setImage(UIImage(named: "Queen"), for: UIControl.State.normal)
			self.value = 8
		case 96...100:
			self.setImage(UIImage(named: "King"), for: UIControl.State.normal)
			self.value = 10
		default: print("error")
	
		}
	}
	
	deinit{
		
	}
	
	func pulsate(){
		let pulse = CASpringAnimation(keyPath: "transform.scale")
		pulse.duration = 0.6
		pulse.fromValue = 0.8
		pulse.toValue = 1.0
		pulse.autoreverses = true
		pulse.repeatCount = 2
		pulse.initialVelocity = 0.5
		pulse.damping = 1.0
		
	}
	
	
	
}
