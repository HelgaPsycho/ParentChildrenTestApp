//
//  ChildrenCell.swift
//  ParentChildrenTestApp
//
//  Created by Ольга Егорова on 27.10.2022.
//

import UIKit
import RAGTextField

class ChildrenCell: UITableViewCell, UITextFieldDelegate {
    
    let family = Family()
    var id: String?
    static let identifier = "ChildrenCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "ChildrenCell", bundle: .none)
    }
    
    
    @IBOutlet weak var nameTextField: RAGTextField!
    
    @IBOutlet weak var ageTextField: RAGTextField!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    public func configure (id: String, name: String, age: String){
        self.id = id
        nameTextField.text = name
        ageTextField.text = age
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameTextField.delegate = self
        ageTextField.delegate = self
        deleteButtonConfigure()
        textFieldConfigure()
        
        
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
       // textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        family.deleteChildren(id: self.id!)
    }
    
    func deleteButtonConfigure () {
        deleteButton.layer.cornerRadius = 20
        deleteButton.layer.borderWidth = 2
        deleteButton.layer.borderColor = CGColor(red: 0.07, green: 0.45, blue: 0.87, alpha: 1.00)
    }
    
    func textFieldConfigure () {
        nameTextField.borderStyle = .roundedRect
        ageTextField.borderStyle = .roundedRect
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        family.changeChildren(id: id!, name: nameTextField.text ?? "", age: ageTextField.text ?? "")
 
    }

}
