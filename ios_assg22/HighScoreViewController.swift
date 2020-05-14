//
//  HighScoreViewController.swift
//  ios_assg22
//
//  Created by ヴァイオレット・エヴァーガーデン on 2/5/20.
//  Copyright © 2020 Harry. All rights reserved.
//

import UIKit

class HighScoreViewController: UIViewController {
	@IBOutlet weak var nameLb: UILabel!
	@IBOutlet weak var scoreLb: UILabel!
	
    override func viewDidLoad() {
	
		nameLb.text = UserDefaults.standard.dictionary(forKey: "ranking")!["userName"] as! String
		scoreLb.text = UserDefaults.standard.dictionary(forKey: "ranking")!["userScore"] as! String
		

		super.viewDidLoad()
    }
	

}
