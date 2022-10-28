//
//  ViewController.swift
//  ParentChildrenTestApp
//
//  Created by Ольга Егорова on 26.10.2022.
//

import UIKit
import RAGTextField

class ViewController: UIViewController, UITextFieldDelegate, Subscriber {

    
    let family = Family()
    
    @IBOutlet weak var nameTextField: RAGTextField!
    
    @IBOutlet weak var ageTextField: RAGTextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var clearButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nameTextField.delegate = self
        ageTextField.delegate = self
        
        startUISettings()
        
        family.subscribe(subscriber: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    internal func textFieldDidEndEditing(_ textField: UITextField) {
        family.parentName = nameTextField.text
        family.parentAge = ageTextField.text
       // return textField.text!
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        
        guard family.childrensId!.count < 5 else {
            print ("Можно добавить не более 5 детей")
            return
        }
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let id = dateFormatter.string(from: date)
        family.addChildren(id: id, name: "", age: "")

    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Сбросить данные", style: .destructive, handler: { (UIAlertAction) in print ("Сбросить данные")
            self.family.deleteAllChildrens()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { (UIAlertAction) in print ("Oтмена")}))
        
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = clearButton.frame
       
        present(alert, animated: true, completion: nil)
    }

    
    func startUISettings () {
        nameTextField.text = family.parentName
        ageTextField.text = family.parentAge
        nameTextField.borderStyle = .roundedRect
        ageTextField.borderStyle = .roundedRect

        addButton.layer.cornerRadius = 20
        addButton.layer.borderWidth = 2
        addButton.layer.borderColor = UIColor.systemBlue.cgColor
        
        clearButton.layer.cornerRadius = 20
        clearButton.layer.borderWidth = 2
        clearButton.layer.borderColor = UIColor.systemRed.cgColor
        clearButton.titleLabel?.textColor = UIColor.systemRed
        
    }
    
    func update() {
        //
    }

}

