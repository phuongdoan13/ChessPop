//
//  GameViewController.swift
//  ios_assg22
//
//  Created by ヴァイオレット・エヴァーガーデン on 2/5/20.
//  Copyright © 2020 Harry. All rights reserved.
//

import UIKit
import AVFoundation
class GameViewController: UIViewController {
	var rankingDictionary = [String : String]()
	var name: String = "Annonymous"
	var time: Int = 0
	var timer: Timer?
	var maxBubbles: Int = 0
	var score: Int = 0
	let initial_hscore = Int(UserDefaults.standard.dictionary(forKey: "ranking")!["userScore"] as! String)!
	var hscore: Int = 0
	var bArray = Array<Bubble>()
	var comboStack = StackInt()
	let MAXIMUM_DIAMETER :UInt32 = 100
	let TOP_BARS_HEIGHT :UInt32 = 200
	let PADDING :UInt32 = 10
	let bubblePop = URL(fileURLWithPath: Bundle.main.path(forResource: "bubbleBurstFreesound", ofType: "wav")!)
	var audioPlayer = AVAudioPlayer()


	@IBOutlet weak var timeLb: UILabel!
	@IBOutlet weak var hscoreLb: UILabel!
	@IBOutlet weak var scoreLb: UILabel!
	@IBOutlet weak var addPoint: UILabel!
	
	//// / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /
	// LIFE CYCLE //
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.backgroundColor = UIColor(patternImage: UIImage(named: "VioletPrincessPhonewppKyotoAnimation")!) //copyright belongs to KyotoAnimation
		// Timer
		timeLb.text = String(time)
		timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerCountDown), userInfo: nil, repeats: true)
		
		// Highscore
		
		hscoreLb.text = String(initial_hscore)
		hscore = initial_hscore

		//add Point
		addPoint.text = ""
	
		// Score
		scoreLb.text = String("0")
		
		// Bubbles
		bubbleGenerateBeginning()
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
		if time == 0 {
			if let timer = timer {
				timer.invalidate()
				self.view.isUserInteractionEnabled =  false
				saveRanking(name: name, score: score)
				if(score > initial_hscore){
					let alert = UIAlertController(title: "Time's Up!", message: "Congratulation! You got a new high score of \(score) points. Awesome!", preferredStyle: .alert)
					alert.addAction(UIAlertAction(title: "Sweet!!!", style: .default, handler: nil))
					self.present(alert, animated: true, completion: nil)
				}else{
					let alert = UIAlertController(title: "Time's Up!", message: "Your time is up! You got a score of \(score) points. Awesome!", preferredStyle: .alert)
					alert.addAction(UIAlertAction(title: "Sweet!!!", style: .default, handler: nil))
					self.present(alert, animated: true, completion: nil)
				}
				
			}
		}
		
		bubbleGenerateDuringGame()
	}
	
	
	// RANDOMLY GENERATE AND REMOVE BUBBLES //
	func bubbleGenerateBeginning(){
		var currentNumberBubbles :Int = self.bArray.count
		
		while(currentNumberBubbles < maxBubbles){
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
				let pulse = CASpringAnimation(keyPath: "transform.scale")
					pulse.duration = 0.6
					pulse.fromValue = 0.8
					pulse.toValue = 1.0
					pulse.autoreverses = true
					pulse.repeatCount = 100
					pulse.initialVelocity = 0.5
					pulse.damping = 1.0
				bubble.layer.add(pulse, forKey:nil)
				currentNumberBubbles = currentNumberBubbles + 1
			}
		}
	}
	
	func randomlyRemoveBubbles(){
		// Logic: At the beginning, every bubble has attribute bArray_index corresponding to its index in bArray.
		// We then loop through bArray REVERSELY.
		// At any element i in the loop, if it is randomly selected to be remove, we will decrement bArry_index of all the elements that have been looped through.
		let bArrayCountAtBeginning = bArray.count
		for i in (0 ..< bArrayCountAtBeginning).reversed(){
			// The probability of being removed is 20%
			if(Int.random(in: 1...5) == 1 && bArray.count > 5){
				for idx in i + 1 ..< bArray.count {
					bArray[idx].bArray_index -= 1
				}
				bArray[i].removeFromSuperview()
				bArray.remove(at: i)
			}
		}
	}

	func bubbleGenerateDuringGame() {
		// #Generate bubbles on the screen every second
		randomlyRemoveBubbles()
		var currentNumberBubbles :Int = self.bArray.count
		let randomUpperNumber = Int.random(in: currentNumberBubbles...maxBubbles)
		while(currentNumberBubbles < randomUpperNumber){
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
				let pulse = CASpringAnimation(keyPath: "transform.scale")
					pulse.duration = 0.6
					pulse.fromValue = 0.8
					pulse.toValue = 1.0
					pulse.autoreverses = true
					pulse.repeatCount = 100
					pulse.initialVelocity = 0.5
					pulse.damping = 1.0
				bubble.layer.add(pulse, forKey:nil)
				currentNumberBubbles = currentNumberBubbles + 1
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
	// REMOVE BUBBLE ON PRESS//
	@objc func bubblePressed(_ bubble:Bubble){
		// # Remove the bubble from the screen
		do{
			audioPlayer = try AVAudioPlayer(contentsOf: bubblePop)
			audioPlayer.play()
			let comboValue = combo(bubble.value)
			score = score + comboValue
			scoreLb.text = String(score)
			addPoint.text = "+\(String(comboValue))"
			if(score > hscore){
				hscore = score
				hscoreLb.text = String(hscore)
			}
			CATransaction.begin()
			CATransaction.setCompletionBlock({
				
				bubble.removeFromSuperview()
			})
			bubble.setImage(UIImage(named: "pop"), for: UIControl.State.normal)
			let buttonAnimation = CABasicAnimation(keyPath: "opacity")
			buttonAnimation.fromValue = 1
			buttonAnimation.toValue = 0
			buttonAnimation.duration = 0.5
			bubble.layer.add(buttonAnimation, forKey:nil)
			CATransaction.commit()
			
			let pulse = CASpringAnimation(keyPath: "transform.scale")
			pulse.duration = 0.6
			pulse.fromValue = 0.8
			pulse.toValue = 1.0
			pulse.autoreverses = true
			pulse.repeatCount = 100
			pulse.initialVelocity = 0.5
			pulse.damping = 1.0
			addPoint.layer.add(pulse, forKey: nil)
			
			bubble.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
			
			
			removePressedBubbleFromArray(bubble)
		}catch{
			print("NO sound")
		}
	}
	
	func removePressedBubbleFromArray(_ bubble:Bubble){
		// # Remove the bubble from the screen
		// Logic: Change the bArray_index field of the bubbles
		// placed after the popped bubble.
		let bubble_bArray_index = bubble.bArray_index
		bArray.remove(at: bubble_bArray_index)
		for idx in bubble_bArray_index ..< bArray.count {
			bArray[idx].bArray_index -= 1
		}
	}
	
	func combo(_ value: Int) -> Int{
		if(comboStack.isEmpty()){
			comboStack.push(value)
			return value
		}else if(comboStack.peek() != value){
			comboStack.clear()
			comboStack.push(value)
			return value
		}else{
			comboStack.push(value)
			return Int(round(Double(value) * 1.5))
		}
	}
	//// / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /
	// SAVE SCORE //
	func saveRanking(name:String?, score: Int){
		if(score > initial_hscore){
			rankingDictionary.updateValue(name!, forKey: "userName")
			rankingDictionary.updateValue(String(score), forKey: "userScore")
			UserDefaults.standard.set(rankingDictionary, forKey:"ranking")
		}
	}
	
}


