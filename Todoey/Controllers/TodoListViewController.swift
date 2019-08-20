//
//  ViewController.swift
//  Todoey
//
//  Created by Soulthidapo on 2019/08/08.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")    //I have mistake documentationDirectory
    
    //let defaults = UserDefaults.standard                // #Singleton
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print(dataFilePath)
        
        loadItems()
        
        
        //To show append list
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//
//            itemArray = items
//        }
        
    }

    //MARK: Tableview Datasource Methods Step 1
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary Operator ==>
        //value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
//        if item.done == true{ //itemArray[indexPath.row]
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
     //MAKE:Tableview Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //checkmark
        
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done  //New Add *****
        
        saveItems()
        //tableView.reloadData() ////new add
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MAKE: Add New Item
    
    @IBAction func addButtonPress(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Style", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What the happen once the user clicks the add item button on our UIAlert
            print("Success!!!!!!!!!!!")
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create new item"
            print(alertTextField.text)
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion : nil)
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do{
            let data =  try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error encoding item array, \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems(){
        
        if let data = try? Data(contentsOf: dataFilePath!){
            
            let decoder = PropertyListDecoder()
            do{
            itemArray = try decoder.decode([Item].self, from: data)
            } catch{
                print("Error decode item , \(error)")
            }
            
            
        }
    }
    
}







