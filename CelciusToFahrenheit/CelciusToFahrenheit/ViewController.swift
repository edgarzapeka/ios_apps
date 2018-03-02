//
//  ViewController.swift
//  CelciusToFahrenheit
//
//  Created by Edgar Zapeka on 2018-03-01.
//  Copyright © 2018 Edgar Zapeka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var switchTempType: UISegmentedControl!
    @IBOutlet weak var converterTitle: UILabel?
    @IBOutlet weak var temperatureTypeTitle: UILabel?
    @IBOutlet weak var selectedTempTypeLabel: UILabel?
    @IBOutlet weak var selectedTempTypeValueLabel: UILabel?
    @IBOutlet weak var convertedTempTypeLabel: UILabel?
    @IBOutlet weak var convertedTempTypeValueLabel: UILabel?
    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initUI()
        
        
    }
    
    @IBAction func switchType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.selectedTempTypeLabel?.text = "Celcius"
            self.convertedTempTypeLabel?.text = "Farenheit"
            calculateTmp()
        case 1:
            self.selectedTempTypeLabel?.text = "Farenheit"
            self.convertedTempTypeLabel?.text = "Celcius"
            calculateTmp()
        default:
            self.selectedTempTypeLabel?.text = "Celcius"
            self.convertedTempTypeLabel?.text = "Farenheit"
        }
    }
    
    
    func initUI(){
        self.converterTitle?.text = "Temperature Converter"
        self.converterTitle?.font = self.converterTitle?.font.withSize(30)
        self.converterTitle?.textAlignment = .center
        
        self.temperatureTypeTitle?.text = "Convert:"
        self.temperatureTypeTitle?.font = self.temperatureTypeTitle?.font.withSize(20)
        self.temperatureTypeTitle?.textAlignment = .center
        
        let titles = ["Celcius", "Farenheit"]
        self.switchTempType?.setTitle(titles[0], forSegmentAt: 0)
        self.switchTempType?.setTitle(titles[1], forSegmentAt: 1)
        
        self.selectedTempTypeLabel?.text = "Celcius"
        self.convertedTempTypeLabel?.text = "Farenheit"
    }
    
    @IBAction func handleInput(_ sender: UITextField) {
        self.selectedTempTypeValueLabel?.text = sender.text
        calculateTmp()
    }
    func calculateTmp(){
        var inputValue: Float = (self.selectedTempTypeValueLabel?.text as! NSString).floatValue
        if (self.selectedTempTypeLabel?.text == "Celcius"){
            self.convertedTempTypeValueLabel?.text = String(inputValue * 9/5 + 32)
        }else{
            self.convertedTempTypeValueLabel?.text = String(inputValue * 1.8 + 32 )
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

