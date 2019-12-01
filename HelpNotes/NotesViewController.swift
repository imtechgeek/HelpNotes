//
//  NotesViewController.swift
//  HelpNotes
//
//  Created by Usman on 01/12/2019.
//  Copyright © 2019 Usman. All rights reserved.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {
    @IBOutlet weak var notesTextView: UITextView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var notes = [Category]()
    var notesBody: String!
    var row: Int!
    var selectedCategory: String? {
        didSet{
            
            
            loadData()
            
            
        }
    }
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        notesTextView.text = notesBody
        notesTextView.becomeFirstResponder()
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        updateData()
        saveData()
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    func saveData(){
        do{
            try context.save()
        }catch{
            print(error)
        }
    }
    func loadData(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        request.predicate = NSPredicate(format: "name MATCHES %@", selectedCategory!)
        do{
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]{
                notesBody = data.value(forKey: "notes") as? String
                
                
            }
        } catch{
            print(error)
        }
        
    }
    func updateData(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        request.predicate = NSPredicate(format: "name MATCHES %@", selectedCategory!)
        do{
            let result = try context.fetch(request) as! [NSManagedObject]
            result[0].setValue(notesTextView.text,forKey: "notes")
            
        } catch{
            print(error)
        }
        
    }
    
}

