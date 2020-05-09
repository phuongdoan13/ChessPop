//
//  GameViewController.swift
//  ios_assg22
//
//  Created by ヴァイオレット・エヴァーガーデン on 2/5/20.
//  Copyright © 2020 Harry. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
	var rankingDictionary = [String : String]()
	var time: Int = 0
	var timer: Timer?
	var maxBubbles: Int = 0
	var score: Double = 0
	var bArray = Array<Bubble>()
	var comboStack = StackInt()
	let MAXIMUM_DIAMETER :UInt32 = 100
	let TOP_BARS_HEIGHT :UInt32 = 200
	let PADDING :UInt32 = 10
	@IBOutlet weak var timeLb: UILabel!
	@IBOutlet weak var hscoreLb: UILabel!
	@IBOutlet weak var nameTf: UITextField!
	@IBOutlet weak var scoreTf: UITextField!
	@IBOutlet weak var scoreLb: UILabel!
	@IBAction func save(_ sender: UIButton) {
		saveRanking(name: nameTf.text, score: scoreTf.text)
	}
	
	//// / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /
	// LIFE CYCLE //
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.backgroundColor = UIColor(patternImage: UIImage(named: "VioletPrincessPhonewpp")!)
		// Timer
		timeLb.text = String(time)
		timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerCountDown), userInfo: nil, repeats: true)
		
		// Highscore
		
		// Score
		scoreLb.text = String("0")
		
		// Bubbles
		bubbleGenerate()
    }
    
	override func viewWillDisappear(_ animated: Bool){
		super.viewWillDisappear(animated)
		if let timer = timer{
			timer.invalidate()
			self.view.isUserInteractionEnabled =  false
		}
	}
	
	//// / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /
	// TIMER //
	@objc func timerCountDown(){
		time = time - 1
		self.timeLb.text = String(time)
		if time <= 0 {
			if let timer = timer {
				timer.invalidate()
				self.view.isUserInteractionEnabled =  false 
			}
		}
		bubbleGenerate()
	}
	
	//// / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /
	// GENERATE BUBBLES //
	func bubbleGenerate() {
		// #Generate bubbles on the screen every second
		var i :Int = self.bArray.count
		while(i < maxBubbles){
			let bubble = Bubble()
			let bubble_size = UInt32.random(in: 60...MAXIMUM_DIAMETER)
			bubble.frame = CGRect(
				x: CGFloat(PADDING + arc4random_uniform(screenWidth - MAXIMUM_DIAMETER - 2 * PADDING )),
				y: CGFloat(TOP_BARS_HEIGHT + arc4random_uniform(screenHeight - MAXIMUM_DIAMETER - PADDING - TOP_BARS_HEIGHT)),
				width: CGFloat(bubble_size),
				height: CGFloat(bubble_size)
			)
			bubble.layer.cornerRadius = bubble.frame.height / 2
			
			if(isNotOverlap(bubble)){ // Add overlap condition here
				
				bubble.addTarget(self, action: #selector(bubblePressed), for : UIControl.Event.touchUpInside)
				bArray.append(bubble)
				bubble.bArray_index = bArray.count - 1 // array index starts from 0
				self.view.addSubview(bubble)
				i = i + 1
			}
		}
	}
    
	func isNotOverlap(_ bubble:Bubble) -> Bool{
		for b in bArray{
			if(bubble.bArray_index != b.bArray_index && bubble.frame.intersects(b.frame)){
				return false
			}
		}
		return true
	}
	
	var screenWidth: UInt32{
		// get the Width of the screen
		return UInt32(UIScreen.main.bounds.width)
	}
	
	var screenHeight: UInt32{
		// get the Height of the screen
		return UInt32(UIScreen.main.bounds.height)
	}
	
	//// / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /
	// REMOVE BUBBLE //
	@objc func bubblePressed(_ bubble:Bubble){
		// # Remove the bubble from the screen
		score = score + combo(bubble.value)
		scoreLb.text = String(score)
		let animation = CABasicAnimation(keyPath:"opacity")
			animation.fromValue = 1
			animation.toValue = 0
			animation.duration = 2.0
			bubble.layer.add(animation, forKey:nil)
			bubble.removeFromSuperview()
		removeBubbleFromArray(bubble)
	}
	
	func removeBubbleFromArray(_ bubble:Bubble){
		// # Remove the bubble from the screen
		// Logic: Change the bArray_index field of the bubbles
		// placed after the popped bubble.
		let bubble_bArray_index = bubble.bArray_index
		bArray.remove(at: bubble_bArray_index)
		for idx in bubble_bArray_index ..< bArray.count {
			bArray[idx].bArray_index -= 1
		}
	}
	
	func combo(_ value: Int) -> Double{
		if(comboStack.isEmpty()){
			comboStack.push(value)
			return Double(value)
		}else if(comboStack.peek() != value){
			comboStack.clear()
			comboStack.push(value)
			return Double(value)
		}else{
			comboStack.push(value)
			return Double(value) * 1.5
		}
	}
	//// / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /
	// SAVE SCORE //
	func saveRanking(name:String?, score:String?){
		rankingDictionary.updateValue(name!, forKey: "userName")
		rankingDictionary.updateValue(score!, forKey: "userScore")
		UserDefaults.standard.set(rankingDictionary, forKey:"ranking")
	}
	
	
	
	
}
