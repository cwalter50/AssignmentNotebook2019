//
//  ViewController.swift
//  AssignmentNotebook
//
//  Created by  on 11/19/19.
//  Copyright © 2019 DocsApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    var list: [Assignment] = [Assignment(theName: "Math HW", theDueDate: "Tomorrow"), Assignment(theName: "Spanish HW", theDueDate: "Friday"), Assignment()]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadListFromUserDefaults()
    }
    
    func loadListFromUserDefaults()
    {
        let defaults = UserDefaults.standard
        if let savedList = defaults.object(forKey: "SavedAssignments") as? Data {
            let decoder = JSONDecoder()
            if let loadedList = try? decoder.decode([Assignment].self, from: savedList)
            {
                list = loadedList
                myTableView.reloadData()
            }
        }
    }
    
    func saveListToUserDefaults()
    {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(list)
        {
            UserDefaults.standard.set(encoded, forKey: "SavedAssignments")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let current = list[indexPath.row]
        cell.textLabel?.text = current.name
        cell.detailTextLabel?.text = current.dueDate
        
        return cell
    }

    @IBAction func addButtonTapped(_ sender: UIBarButtonItem)
    {
        // create an alert to add an assignment to the tableview and list
        let alert = UIAlertController(title: "Add an Assignment", message: "enter info below", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: {
            textfield in
            textfield.placeholder = "Enter Assignment Name"
        })
        alert.addTextField(configurationHandler: {
            textfield in
            textfield.placeholder = "Enter Due Date"
        })
        
        let addAction = UIAlertAction(title: "Add", style: .default, handler: {action in
            // grab the TF's
            let nameTF = alert.textFields![0]
            let dateTF = alert.textFields![1]
            // create a new assignment from the data in the TFs
            let newAssignment = Assignment(theName: nameTF.text!, theDueDate: dateTF.text!)
            // add new Assignment to list (Array)
            self.list.append(newAssignment)
            // reload the tableview
            self.myTableView.reloadData()
            
            // save new list to user defaults
            self.saveListToUserDefaults()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: {action in
            // do nothing and dismiss
        })
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}

