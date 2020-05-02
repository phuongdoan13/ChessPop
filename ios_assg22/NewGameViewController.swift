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
	@IBOutlet weak var nameLb: UILabel!
	@IBOutlet weak var timerSl: UISlider!
	@IBOutlet weak var timerLb: UILabel!
	@IBAction func changeTimer(_ sender: UISlider) {
		time = Int(sender.value)
		timerLb.text = String(time)
	}
	override func viewDidLoad() {
		time = Int(timerSl.value)
		timerLb.text = String(time)
		nameLb.text = name
		super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let vc = segue.destination as? GameViewController{
			vc.time = time
		}
	}
    



}
