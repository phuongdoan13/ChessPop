//
//  WelcomeViewController.swift
//  ios_assg22
//
//  Created by ヴァイオレット・エヴァーガーデン on 2/5/20.
//  Copyright © 2020 Harry. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

	@IBOutlet weak var welcomeButton: UIButton!

	override func viewDidLoad() {
		if var rankingDictionary = UserDefaults.standard.dictionary(forKey: "ranking") as! [String: String]?{
			rankingDictionary.updateValue("Anonymous", forKey: "userName")
			rankingDictionary.updateValue("0", forKey: "userScore")
			UserDefaults.standard.set(rankingDictionary, forKey:"ranking")
		}
		super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
	

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
