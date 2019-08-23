//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Soulthidapo on 2019/08/21.
//  Copyright © 2019 Soul. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
//    let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
//    Realm.Configuration.defaultConfiguration = config

    
    let realm = try! Realm()   //249
    
    var categories : Results<Category>?  //250
    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

    }
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell" , for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"//250
        
        return cell
    }
    
     //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedCategory = categories?[indexPath.row]  //250
        }
    }
    
    //MARK: - Data Manipulation Methods
    
    func save(category: Category){
        do{
            try realm.write {
                realm.add(category)
            }
            
        }catch{
            print("Error saving context, \(error)")
        }
        tableView.reloadData()
        
    }
    
    func  loadCategories(){   //249 com
        
         categories = realm.objects(Category.self) //250
 
         tableView.reloadData()
        
    }
    
    //MARK: - Add New Categories
    
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            //let newCategory = Category(context: self.context)
            let newCategory = Category() //249
            newCategory.name = textField.text!
            
            //self.categories.append(newCategory)    //250
            
            self.save(category: newCategory)
            
        }
        
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new category"
            
        }
        
        present(alert, animated: true, completion : nil)
    }
    
}
