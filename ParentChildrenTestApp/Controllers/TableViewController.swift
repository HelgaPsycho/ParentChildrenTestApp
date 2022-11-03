//
//  TableViewController.swift
//  ParentChildrenTestApp
//
//  Created by Ольга Егорова on 27.10.2022.
//

import UIKit

class TableViewController: UITableViewController, UITextFieldDelegate, Subscriber {
    
    var family = Family()
    
    @IBOutlet var childrensTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ChildrenCell.nib(), forCellReuseIdentifier: ChildrenCell.identifier)
        self.tableView.rowHeight = 150
        family.subscribe(subscriber: self)
        
       dismissKeyboardWhenTouchOutside()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return family.childrensId!.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = childrensTableView.dequeueReusableCell(withIdentifier: ChildrenCell.identifier, for: indexPath) as! ChildrenCell
        
        let id = family.childrensId![indexPath.row]
        let name = family.childrensNames![indexPath.row]
        let age = family.childrensAges![indexPath.row]
        customCell.configure(id: id, name: name, age: age)

        return customCell

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
  
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
   //MARK: - Subscriber
    
    func update() {
    
        tableView.register(ChildrenCell.nib(), forCellReuseIdentifier: ChildrenCell.identifier)
        //self.tableView.rowHeight = 150
        DispatchQueue.main.async {
                    self.childrensTableView.reloadData()
                }
    }


    func dismissKeyboardWhenTouchOutside () {
    
    let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        
        tableView.keyboardDismissMode = .onDrag

    }
    
}

