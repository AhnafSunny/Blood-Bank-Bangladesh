//
//  RequestBloodViewController.swift
//  Blood Bank Bangladesh
//
//  Created by Ahnaf on 4/30/17.
//  Copyright © 2017 Ahnaf. All rights reserved.
//

import UIKit
//import Firebase
import FirebaseDatabase
import FirebaseAuth


class RequestBloodViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate{
    
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var ref: FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?
    var databaseHandle2: FIRDatabaseHandle?
    
    
    //var contactList : [String:String] = [:]
    let bglist = ["A+","A-","B+","B-","O+","O-","AB+","AB-"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Request Blood")
        
        //set reference for Firebase database reference
        ref = FIRDatabase.database().reference()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func SubmitRequest(_ sender: Any) {
        print("request blood fired")
        //get current user email
        let currEmail = FIRAuth.auth()?.currentUser?.email!
        //print(currEmail)
        let newemail = Utilities().createNewEmail(oldEmail: currEmail!)
        
        //get current user Number
        var number = "NULL"
        
        self.databaseHandle2 = self.ref?.child("UserDetails").child(newemail).observe(.value, with: { (datasnap) in
            let mobilenumber = datasnap.value as? [String:String] ?? [:]
            number = mobilenumber["mobile"]!
            print(number)
            
        })
        
        ref?.removeObserver(withHandle: databaseHandle2!)
        
        let bg:String = titleLabel.text! as String
        
        //get the email contacts of people with the desired blood group
        databaseHandle = ref?.child("BloodGroups-User").child(bg).observe(.childAdded, with: { (snapshot) in
            //send messages to the users with the desired blood group
            let user = snapshot.value as! Dictionary< String,String>
            if let receiverEmail = user[Constants.BloodGroup.email] as String!{
                    let emailid = Utilities().createNewEmail(oldEmail: receiverEmail)
                    var data = [Constants.RequestMessage.message : "Need Blood"]
                    data[Constants.RequestMessage.sender] = number
                    self.ref?.child("Messages").child(emailid).childByAutoId().setValue(data)
                
                
            }
            
        
        })
        
        ref?.removeObserver(withHandle: databaseHandle!)
        
    }
    
    
    //pickerView Functions
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return bglist[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bglist.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        titleLabel.text = bglist[row]
    }
    
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
