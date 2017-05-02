////
////  DAL.swift
////  Blood Bank Bangladesh
////
////  Created by Ahnaf on 5/1/17.
////  Copyright © 2017 Ahnaf. All rights reserved.
////
//
import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth


class DAL{
    
    var ref: FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?
    
//    func currentUserEmail() -> String{
//    }
    
    func UserNumber(email:String) -> String {
        //let userID = FIRAuth.auth()?.currentUser?.uid
        var number = "NIL"
        
        databaseHandle = ref?.child("UserDetails").child("ahnafx88@gmail.com").observe(FIRDataEventType.value, with: { (snapshot) in
            let test = snapshot.value as? [String : AnyObject] ?? [:]
            print("inside handle")
            
        })
        
        
//        ref?.child("UserDetails").child("ahnafx88@gmail.com").observeSingleEvent(of: .value, with: { (snapshot) in
//            // Get Number
//            let value = snapshot.value as? NSDictionary
//            number = value?["mobile"] as? String ?? "Nothing Found"
//            //let user = User.init(username: username)
//            print(number)
//            print("Finished")
//            
//            // ...
//        }) { (error) in
//            print(error.localizedDescription)
//        }
        return number
    }


}
