//
//  ViewController.swift
//  Realm
//
//  Created by Saleh Majıdov on 2/1/18.
//  Copyright © 2018 Saleh Majıdov. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        loadItems()
        
        
    }
    //MARK-- TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count  
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        // value = condition ? valueiftype : valueiffalse
        cell.accessoryType = item.done ? .checkmark : .none
      
//        if item.don == true{
//            cell.accessoryType = .checkmark
//        }
//        else{
//            cell.accessoryType = .none
//        }
        
        return cell
        
    }
    //MARK-- TableView Delegate Methods
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

   
    itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    saveItems()
    
    
    tableView.deselectRow(at: indexPath, animated: true)
  
    }
    
    //MARK-- Add New Items
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add new Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
         // what will happen once user click
            
          
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            self.saveItems()
            
   
            
           
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
           
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        //MARK-- Model Manupulation Methods
        
    
        
        
        
    }
    func saveItems(){

        
        do{
         
         let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
           try context.save()
        }
        catch{
            print("error saving context \(error)")
        }
        
        
        self.tableView.reloadData()
    }
    
//    func loadItems(){
//        if let data = try? Data(contentsOf: dataFilePath!){
//            let decoder = PropertyListDecoder()
//            do{
//            itemArray = try decoder.decode([Item].self, from: data)
//            }
//            catch{
//                print("error decoding array \(error)")
//            }
//
//
//        }
//
//    }
   
    
    
}

