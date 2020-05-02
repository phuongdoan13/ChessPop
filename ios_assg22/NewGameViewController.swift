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
	@IBOutlet weak var nameLb: UILabel!
	override func viewDidLoad() {
		nameLb.text = name
		super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    



}
