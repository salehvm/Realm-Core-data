//
//  CategoryViewController.swift
//  Realm
//
//  Created by Saleh Majıdov on 2/9/18.
//  Copyright © 2018 Saleh Majıdov. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categories = [Category]()
   let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    loadCategories()
        
    }

    // MARK-- TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let item = categories[indexPath.row]
        
        cell.textLabel?.text = item.name
        
        return cell
    }
    
    
    // MARK-- TableView Delegate Methods
    
    
    
    // MARK-- Data Manipulation Methods
    
    func saveCategories(){
      
        do{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        try context.save()
        }
        catch{
            print("error saveing categories \(error)")
        }
        tableView.reloadData()
        
    }
    
    func loadCategories(){
        
        let reuqest : NSFetchRequest<Category> = Category.fetchRequest()
        do{
          categories = try context.fetch(reuqest)
        }
        catch{
            print("error load categories \(error)")
        }
        tableView.reloadData()
    }
    
    
    
    //MARK-- Add new Categories
    


    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "ADD", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            
            self.categories.append(newCategory)
            
            self.saveCategories()
            
        }
        
        
        
        alert.addTextField { (field) in
            field.placeholder = "Add new a category"
            textField = field
            
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
}




