//
//  AddNoteViewController.swift
//  SimpleNotes
//
//  Created by Edgar Zapeka on 2018-03-08.
//  Copyright © 2018 Edgar Zapeka. All rights reserved.
//

import UIKit
import CoreData

class AddNoteViewController: UIViewController {

    @IBOutlet weak var titleValue: UITextField!
    @IBOutlet weak var descriptionValue: UITextView!
    @IBOutlet weak var dateValue: UIDatePicker!
    
    @IBAction func submit(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
        
        if (titleValue?.text == nil || titleValue.text == "" || descriptionValue?.text == nil || descriptionValue.text == ""){
            alertWindow(title: "Validation Error", message: "All fields are required", buttonTitle: "Close")
        } else{
            let newNote = NSManagedObject(entity: entity!, insertInto: context)
            newNote.setValue(titleValue.text, forKey: "title")
            newNote.setValue(descriptionValue.text, forKey: "body")
            newNote.setValue(dateValue.date, forKey: "date")
            
            do{
                try context.save()
                self.titleValue.text = ""
                self.descriptionValue.text = ""
                
                alertWindow(title: "Saved!", message: "The note save successfully. Go and check it in your list", buttonTitle: "Ok")
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
