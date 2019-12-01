//
//  ViewController.swift
//  HelpNotes
//
//  Created by Usman on 30/11/2019.
//  Copyright © 2019 Usman. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
 var itemArray = [Category]()
    var textField = UITextField()

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TypeCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        self.tableView.separatorColor = UIColor.clear
        loadData()
        
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! TypeCell
        cell.noteTitleLabel.text = itemArray[indexPath.row].name
        return cell
        
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Notes Category", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Add Category", style: .default) { (action) in
            let newCategory = Category(context: self.context)
            newCategory.name = self.textField.text
            newCategory.notes = ""
            self.itemArray.append(newCategory)
            self.saveData()
            
        })
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add Category"
            self.textField = alertTextField
        }
        self.present(alert,animated: true)

    }
    func saveData(){
        do{
            try context.save()
        } catch{
            print(error)
        }
        self.tableView.reloadData()
    }
    func loadData(){
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do{
            itemArray = try context.fetch(request)
        } catch{
            print(error)
        }
          tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! NotesViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = itemArray[indexPath.row].name
            destinationVC.row = indexPath.row
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToNotes", sender: self)
        

    }
}

