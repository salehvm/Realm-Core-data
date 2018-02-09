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
 
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

            print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

    
        loadItems()
        
        
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
      

        return cell
        
    }
    //MARK-- TableView Delegate Methods
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    context.delete(itemArray[indexPath.row])
//    itemArray.remove(at: indexPath.row)
//
   
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
    //        externial  internial                         default
    func loadItems(){
    
    let request : NSFetchRequest<Item> = Item.fetchRequest()
        do{
           itemArray = try context.fetch(request)
        }
        catch{
            print("error fetching from context \(error)")
        }
        tableView.reloadData()
    }
 
    
}

//MARK-- searchbar Methods
extension TodoListViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            let request : NSFetchRequest<Item> = Item.fetchRequest()
      let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.predicate = predicate

     let sortDescriptors = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDescriptors]
        do{
            itemArray = try context.fetch(request)
        }
        catch{
            print("error fetching from context \(error)")
        }
        tableView.reloadData()

    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
}




