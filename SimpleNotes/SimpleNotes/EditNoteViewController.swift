//
//  EditNoteViewController.swift
//  SimpleNotes
//
//  Created by Edgar Zapeka on 2018-03-08.
//  Copyright © 2018 Edgar Zapeka. All rights reserved.
//

import UIKit
import CoreData

class EditNoteViewController: UIViewController {
    
    var noteTitle: String = ""
    var noteBody: String = ""
    var noteDate: Date = Date.init()

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var bodyField: UITextView!
    @IBOutlet weak var dateField: UIDatePicker!
    
    
    @IBAction func saveAction(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
        
        if (titleField?.text == nil || titleField.text == "" || bodyField?.text == nil || bodyField.text == ""){
            alertWindow(title: "Validation Error", message: "All fields are required", buttonTitle: "Close")
        } else{
            
            do{
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
                request.returnsObjectsAsFaults = false
                
                let result = try context.fetch(request)
                for data in result as! [NSManagedObject]{
                    if (data.value(forKey: "title") as! String == self.noteTitle){
                        data.setValue(self.titleField.text, forKey: "title")
                        data.setValue(self.bodyField.text, forKey: "body")
                        data.setValue(self.dateField.date, forKey: "date")
                        break
                    }
                }
                
                try context.save()
                
                self.navigationController?.popToRootViewController(animated: true)
            } catch{
                alertWindow(title: "Error", message: "Something went wrong and we couldn't save data. Try again", buttonTitle: "Close")
            }
        }
    }
    
    
    func alertWindow(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleField.text = self.noteTitle
        self.bodyField.text = self.noteBody
        self.dateField.date = self.noteDate
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
