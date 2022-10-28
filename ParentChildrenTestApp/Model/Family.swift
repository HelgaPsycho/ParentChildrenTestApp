//
//  Family.swift
//  ParentChildrenTestApp
//
//  Created by Ольга Егорова on 26.10.2022.
//

import Foundation
class Family {
    
    init(){}
    
    var parentName: String?{
        
        get {
            if let name = UserDefaults.standard.string(forKey: "name") {return name}
            else {return ""}
        }
        
        set {
            let defaults = UserDefaults.standard
            let key = "name"
            if let parentName = newValue {
                print ("Value \(String(describing: newValue)) added to key \(key)")
                defaults.set(parentName, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    var parentAge: String? {
        get {
            return UserDefaults.standard.string(forKey: "age")
            
        }
        
        set{
            let defaults = UserDefaults.standard
            let key = "age"
            if let parentAge = newValue {
                print ("Value \(String(describing: newValue)) added to key \(key)")
                defaults.set(parentAge, forKey: "age")
            }
            
        }
    }

    var childrensId: [String]? {
        get {
            if let array = UserDefaults.standard.array(forKey: "idArray"){
                return array as? [String]
            }
            else {let array = [String]()
                  return array}
        }
        set {
            let defaults = UserDefaults.standard
            let key = "idArray"
            if let childrensId = newValue {
                print ("Value \(String(describing: newValue)) added to key \(key)")
                defaults.set(childrensId, forKey: key)
            }
        }
    }
    
    var childrensNames: [String]? {
        get {
            if let array = UserDefaults.standard.array(forKey: "childrensNamesArray") {
                return array as? [String]
            }
            else { let array = [String]()
                return array }
        }
        
        set {
            let defaults = UserDefaults.standard
            let key = "childrensNamesArray"
            if let childrensNames = newValue {
                print ("Value \(String(describing: newValue)) added to key \(key)")
                defaults.set(childrensNames, forKey: key)
            }
            
        }
    }
    
    var childrensAges: [String]? {
        get {
            if let array = UserDefaults.standard.array(forKey: "childrensAgesArray") {
                return array as? [String]
            }
            else { let array = [String]()
                return array }
        }
        
        set {
            let defaults = UserDefaults.standard
            let key = "childrensAgesArray"
            if let childrensAges = newValue {
                print ("Value \(String(describing: newValue)) added to key \(key)")
                defaults.set(childrensAges, forKey: key)
            }
            
        }
    }

    
    func addChildren (id: String, name: String, age: String) {

        childrensId!.append(id)
        childrensNames!.append(name)
        childrensAges!.append(age)
        let defaults = UserDefaults.standard
        defaults.set(childrensId, forKey: "idArray")
        defaults.set(childrensNames, forKey: "childrensNamesArray")
        defaults.set(childrensAges, forKey: "childrensAgesArray")
        notifySubscribers ()
    }
    
    func changeChildren (id: String, name: String, age: String) {
        guard let index = childrensId?.firstIndex(of: id)
        else {
            print ("Children not find")
            return
        }
        
        childrensNames![index] = name
        childrensAges![index] = age
        
    }
    
    func deleteChildren (id: String){
        
        guard let index = childrensId?.firstIndex(of: id)
               else {
                   print ("No children with same name")
                   return
               }
        
        var newChildrensNamesArray = childrensNames
        var newChildrensAgesArray = childrensAges
        var newChildrensIdArray = childrensId
        
        newChildrensNamesArray?.remove(at: index)
        newChildrensAgesArray?.remove(at: index)
        newChildrensIdArray?.remove(at: index)
        
        childrensNames = newChildrensNamesArray
        childrensAges = newChildrensAgesArray
        childrensId = newChildrensIdArray
        notifySubscribers ()
    
    }
    
    
    func deleteAllChildrens (){
        childrensId = []
        childrensNames = []
        childrensAges = []
        notifySubscribers ()
    
    }
    //MARK: - Observer
    
    static var subscribers: [Subscriber] = []
    
    func subscribe (subscriber: Subscriber) {
        Family.subscribers.append(subscriber)
    }
    
    func notifySubscribers (){
        for subscriber in Family.subscribers {
            subscriber.update()
        }
    }
    
}



protocol Subscriber {
    func update ()
}
