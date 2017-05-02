//
//  Utilities.swift
//  BokBok
//
//  Created by Ahnaf on 12/25/16.
//  Copyright © 2016 Ahnaf. All rights reserved.
//

import Foundation
import UIKit

class Utilities {

    func ShowAlert (title: String , message: String, vc: UIViewController){
        let alert = UIAlertController(title: title,message:message,preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
        vc.present(alert,animated:true,completion:nil)
        
        
    }
    
    func GetDate () -> String {
        let today: Date = Date()
        let dateFormatter : DateFormatter = DateFormatter ()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        return dateFormatter.string(from: today)
    }
    
    func createNewEmail(oldEmail: String) -> String{
        //this does not handle the dots well when a dot is present before @
        //need to improve on this
        
        let fullArr = oldEmail.characters.split(separator: ".")
        
        let first = String(fullArr [0])
        let second = String(fullArr[1])
        
        let total = first + "0" + second
        
        
        return total
    }
    
    
    func CheckBloodGroup(bg: String) -> Bool{
        
        
        switch bg {
        case "o+","O+"  :
            
            return true
        case "o-","O-"  :
            
            return true
        case "A+","a+"  :
            print( "A")
            return true
        case "A-","a-"  :
            
            return true
        case "B+","b+"  :
            
            return true
        case "B-","b-"  :
            
            return true
            
        case "AB+","ab+","aB+","Ab+"  :
            
            return true
            
        case "AB-","ab-","aB-","Ab-"  :
            
            return true
            
        default :
            
            return false
        }
        
        
    }
    
    func GetBloodGroup(bg: String) -> String{
        
        switch bg {
        case "o+","O+"  :
            
            return "O+"
        case "o-","O-"  :
            
            return "O-"
        case "A+","a+"  :
            
            return "A+"
        case "A-","a-"  :
            
            return "A-"
        case "B+","b+"  :
            
            return "B+"
        case "B-","b-"  :
            
            return "B-"
            
        case "AB+","ab+","aB+","Ab+"  :
            
            return "AB+"
            
        case "AB-","ab-","aB-","Ab-"  :
            
            return "AB-"
            
        default :
            
            return "Invalid Input"
        }
        
        
    }
    
    
    

}
