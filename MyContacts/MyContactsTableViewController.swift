//
//  MyContactsTableViewController.swift
//  MyContacts
//
//  Created by Nina Longasa on 3/29/16.
//  Copyright © 2016 CHCAppDev. All rights reserved.
//

import UIKit
import CoreData

class MyContactsTableViewController: UITableViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    var myContacts = [MyContacts]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addMyContact:")
        
        reloadData()
        
        // Displays the name of the application and the number of contacts in the Core Data
        
        if myContacts.count < 2 {
            title = "MyContacts: " + String(myContacts.count) + " Contact"
            reloadData()
        } else {
            title = "MyContacts: " + String(myContacts.count) + " Contacts"
            reloadData()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        // Fetch data from the MyContacts entity
    func reloadData(){
        
        let fetchRequest = NSFetchRequest(entityName: "MyContacts")
        
        do {
            if let results = try managedObjectContext.executeFetchRequest(fetchRequest) as? [MyContacts] {
                    myContacts = results
                tableView.reloadData() // Called from the table view controller
            }
        } catch {
            fatalError("There was an error fetching your contacts!")
        }
        
    }
    
        // This method adds the information to the MyContacts Core Data
    func addMyContact(sender: AnyObject?) {
        
        let alert = UIAlertController(title: "Add", message: "MyContacts", preferredStyle: .Alert)
        
        let addAction = UIAlertAction(title: "Add", style: .Default) { (action) -> Void in
            
                // Checks the user if they entered a non-empty String
                // This also sets up immutable text fields
            if let nameTextField = alert.textFields?[0], phoneTextField = alert.textFields?[1], emailTextField = alert.textFields?[2], myContactsEntity = NSEntityDescription.entityForName("MyContacts", inManagedObjectContext: self.managedObjectContext), name = nameTextField.text, phone = phoneTextField.text, email = emailTextField.text {
            
                    // Create managed object instance for MyContacts Entity
                let newMyContacts = MyContacts(entity: myContactsEntity, insertIntoManagedObjectContext: self.managedObjectContext)
                
                newMyContacts.name = name
                newMyContacts.phone = phone
                newMyContacts.email = email
                
                    // Saving the data
                do {
                    try self.managedObjectContext.save()
                } catch {
                    print("Error saving the managed object context!")
                }
                
                self.reloadData() // Fetches data to reload it
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler{ (textField) in
            textField.placeholder = "Name"
        }
        alert.addTextFieldWithConfigurationHandler{ (textField) in
            textField.placeholder = "Phone"
        }
        alert.addTextFieldWithConfigurationHandler{ (textField) in
            textField.placeholder = "Email"
        }
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
        
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myContacts.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyContactsCell", forIndexPath: indexPath)

        // Configure the cell...
        let myContact = myContacts[indexPath.row]
        cell.textLabel?.text = myContact.name
        cell.detailTextLabel?.text = myContact.phone + " | " + myContact.email

        return cell
    }
    

            // This function is needed in order to delete an item
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

            // This function deletes the selected contact list in the MyContacts App
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let contact = myContacts[indexPath.row]
            
            managedObjectContext.deleteObject(contact)
            
            do {
                try self.managedObjectContext.save()
            } catch {
                print("Error saving the managed object context!")
            }
            
            reloadData()
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
