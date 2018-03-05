//
//  ViewController.swift
//  CelciusToFahrenheit
//
//  Created by Edgar Zapeka on 2018-03-01.
//  Copyright © 2018 Edgar Zapeka. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var switchTempType: UISegmentedControl!
    @IBOutlet weak var converterTitle: UILabel?
    @IBOutlet weak var temperatureTypeTitle: UILabel?
    @IBOutlet weak var selectedTempTypeValueLabel: UILabel?
    @IBOutlet weak var convertedTempTypeLabel: UILabel?
    @IBOutlet weak var convertedTempTypeValueLabel: UILabel?
    @IBOutlet weak var textField: UITextField?
    @IBOutlet weak var stepperField: UIStepper?
    
    @IBOutlet weak var roundLabel: UILabel!
    
    var selectedTempType: String = "Celcius"
    var switcherVal : Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initUI()
        
        
    }
    
    @IBAction func switchType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedTempType = "Celcius"
            self.convertedTempTypeLabel?.text = "Farenheit"
            calculateTmp()
        case 1:
            selectedTempType = "Farenheit"
            self.convertedTempTypeLabel?.text = "Celcius"
            calculateTmp()
        default:
            selectedTempType = "Celcius"
        }
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        switcherVal = sender.isOn
        calculateTmp()
    }
    
    func initUI(){
        self.converterTitle?.text = "Temperature Converter"
        self.converterTitle?.font = self.converterTitle?.font.withSize(30)
        self.converterTitle?.textAlignment = .center
        
        self.temperatureTypeTitle?.text = "Convert:"
        self.temperatureTypeTitle?.font = self.temperatureTypeTitle?.font.withSize(20)
        self.temperatureTypeTitle?.textAlignment = .center
        
        self.selectedTempTypeValueLabel?.font = self.converterTitle?.font.withSize(24)
        self.selectedTempTypeValueLabel?.textAlignment = .center
        
        self.convertedTempTypeLabel?.font = self.converterTitle?.font.withSize(24)
        self.convertedTempTypeLabel?.textAlignment = .center
        
        self.roundLabel.text = "Round result?"
        self.roundLabel?.font = self.converterTitle?.font.withSize(24)
        self.roundLabel?.textAlignment = .center
        
        let titles = ["Celcius", "Farenheit"]
        self.switchTempType?.setTitle(titles[0], forSegmentAt: 0)
        self.switchTempType?.setTitle(titles[1], forSegmentAt: 1)
        
        self.convertedTempTypeLabel?.text = "Farenheit"
        selectedTempTypeValueLabel?.text = "0"
        calculateTmp()
        stepperField?.value = 0
    }
    
    @IBAction func handleInput(_ sender: UITextField) {
        if (sender.text == nil || sender.text == ""){
            selectedTempTypeValueLabel!.text = "0"
            stepperField?.value = 0
        }else{
            selectedTempTypeValueLabel!.text = Double(sender.text!)!.description
            stepperField?.value = Double(sender.text!)!
            
        }
        
        calculateTmp()
    }
    func calculateTmp(){
        var inputValue: Float = (self.selectedTempTypeValueLabel?.text as! NSString).floatValue
        if (selectedTempType == "Celcius"){
            self.convertedTempTypeValueLabel?.text =  switcherVal ? String(round(inputValue * 9/5 + 32)) : String(inputValue * 9/5 + 32)
        }else{
            self.convertedTempTypeValueLabel?.text =  switcherVal ? String(round(inputValue - 32 * 5/9)) : String(inputValue - 32 * 5/9)
        }
    }

    @IBAction func stepperAction(_ sender: UIStepper) {
        selectedTempTypeValueLabel?.text = sender.value.description
        calculateTmp()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

