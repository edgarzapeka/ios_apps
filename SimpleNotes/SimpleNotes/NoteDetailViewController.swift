//
//  NoteDetailViewController.swift
//  SimpleNotes
//
//  Created by Edgar Zapeka on 2018-03-08.
//  Copyright © 2018 Edgar Zapeka. All rights reserved.
//

import UIKit
import CoreData

class NoteDetailViewController: UIViewController {
    
    @IBOutlet weak var dateValue: UILabel!
    @IBOutlet weak var titleValue: UILabel!
    @IBOutlet weak var descriptionValue: UITextView!
    
    
    var noteTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        request.returnsObjectsAsFaults = false
        
        do{
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]{
                if ((data.value(forKey: "title") as! String) == noteTitle){
                    self.dateValue.text = (data.value(forKey: "date") as! Date).description
                    self.descriptionValue.text = data.value(forKey: "body") as! String
                    self.titleValue.text = noteTitle
                    break
                }
            }
        }catch{
            print("failed to fetch data")
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func deleteRecord(_ sender: UIButton) {
        var refreshAlert = UIAlertController(title: "Delete Record", message: "Are you sure you want to delete this note?", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            // Do any additional setup after loading the view, typically from a nib.
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            request.returnsObjectsAsFaults = false
            
            do{
                let result = try context.fetch(request)
                for data in result as! [NSManagedObject]{
                    if (data.value(forKey: "title") as! String == self.noteTitle){
                        context.delete(data)
                        break
                    }
                }
                try context.save()
                    self.navigationController?.popToRootViewController(animated: true)
            }catch{
                print("failed to fetch data")
            }
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        self.present(refreshAlert, animated: true, completion: nil)
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
