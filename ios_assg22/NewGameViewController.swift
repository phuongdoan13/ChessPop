//
//  newGameViewController.swift
//  ios_assg22
//
//  Created by ヴァイオレット・エヴァーガーデン on 2/5/20.
//  Copyright © 2020 Harry. All rights reserved.
//

import UIKit

class NewGameViewController: UIViewController {
	var name = ""
	var time :Int = 0
	var maxBubbles :Int = 0
	@IBOutlet weak var nameLb: UILabel!
	
	@IBOutlet weak var timerSl: UISlider!
	@IBOutlet weak var timerLb: UILabel!
	
	@IBOutlet weak var maxBubblesSl: UISlider!
	
	@IBOutlet weak var maxBubblesLb: UILabel!
	
	@IBAction func changeTimer(_ sender: UISlider) {
		time = Int(sender.value)
		timerLb.text = String(time)
	}
	
	@IBAction func changeMaxBubbles(_ sender: UISlider) {
		maxBubbles = Int(sender.value)
		maxBubblesLb.text = String(maxBubbles)
	}
	
	override func viewDidLoad() {
		nameLb.text = name
		
		// Set the default appearance of timerSl/Lb
		time = Int(timerSl.value)
		timerLb.text = String(time)
		
		// Set the default appearance of maxSl/Lb
		maxBubbles = Int(maxBubblesSl.value)
		maxBubblesLb.text = String(maxBubbles)
		
		super.viewDidLoad()
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let vc = segue.destination as? GameViewController{
			vc.name = name
			vc.time = time
			vc.maxBubbles = maxBubbles
		}
	}
}
