//
//  ViewController.swift
//  CelciusToFahrenheit
//
//  Created by Edgar Zapeka on 2018-03-01.
//  Copyright © 2018 Edgar Zapeka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.myLabel?.text = "Temperature Converter"
        self.myLabel?.font = self.myLabel?.font.withSize(30)
        self.myLabel?.textAlignment = .center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

