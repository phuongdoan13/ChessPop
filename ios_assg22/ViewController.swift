//
//  ViewController.swift
//  ios_assg22
//
//  Created by ヴァイオレット・エヴァーガーデン on 2/5/20.
//  Copyright © 2020 Harry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	var nameText = ""
	@IBOutlet weak var nameTf: UITextField!
	
	@IBAction func newGame(_ sender: UIButton) {
		if (nameTf.text == ""){
			nameText = randomString(length: 8)
		}else{
			nameText = nameTf.text!
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let vc = segue.destination as? NewGameViewController{
			vc.name = nameText
		}
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	func randomString(length: Int) -> String {
	  let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	  return String((0..<length).map{ _ in letters.randomElement()! })
	}

}

