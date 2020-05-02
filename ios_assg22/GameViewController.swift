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
	@IBOutlet weak var timeLb: UILabel!
	@IBOutlet weak var nameTf: UITextField!
	
	@IBOutlet weak var scoreTf: UITextField!
	
	@IBAction func save(_ sender: UIButton) {
		saveRanking(name: nameTf.text, score: scoreTf.text)
	}
	
    
	func saveRanking(name:String?, score:String?){
		rankingDictionary.updateValue(name!, forKey: "userName")
		rankingDictionary.updateValue(score!, forKey: "userScore")
		UserDefaults.standard.set(rankingDictionary, forKey:"ranking")
	}
	
	override func viewDidLoad() {
		timeLb.text = String(time)
		super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
}
