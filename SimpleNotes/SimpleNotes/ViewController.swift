//
//  ViewController.swift
//  SimpleNotes
//
//  Created by Edgar Zapeka on 2018-03-08.
//  Copyright © 2018 Edgar Zapeka. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController{

    var noteTitles : [String] = []
    var selectedNoteIndex : Int = 0
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noteTitles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = self.noteTitles[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Notes"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedNoteIndex = indexPath.row
        self.performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let datail = segue.destination as! NoteDetailViewController
        datail.noteTitle = self.noteTitles[self.selectedNoteIndex]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        self.noteTitles = []
        fetchNotes()
        super.viewWillAppear(animated)
    }
    
    func fetchNotes(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
    
        // Do any additional setup after loading the view, typically from a nib.
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        request.returnsObjectsAsFaults = false
    
        do{
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]{
                self.noteTitles.append(data.value(forKey: "title") as! String)
            }
        }catch{
            print("failed to fetch data")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

