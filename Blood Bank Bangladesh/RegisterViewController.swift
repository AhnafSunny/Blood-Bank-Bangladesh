//
//  RegisterViewController.swift
//  Blood Bank Bangladesh
//
//  Created by Ahnaf on 4/22/17.
//  Copyright © 2017 Ahnaf. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var bloodGroup: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var ref: FIRDatabaseReference!
    private var _refHandle: FIRDatabaseHandle!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Register screen loaded")
        // Do any additional setup after loading the view.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(SignInViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        ConfigureDatabase()
    }
    
    func ConfigureDatabase(){
        ref = FIRDatabase.database().reference()
//        _refHandle = self.ref.child("messages").observe(.childAdded,with: {
//            (snapshot) -> Void in
//            self.messages.append(snapshot)
//            //self.tableView.insertRows(at: [IndexPath(row: self.messages.count-1,section:0)], with: .automatic)
//        })
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func CheckBloodGroup() -> Bool{
        let bg = self.bloodGroup.text!
        
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
    
    func GetBloodGroup() -> String{
        let bg = self.bloodGroup.text!
        
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
    
    
    
    func CheckInput() -> Bool {
        
        
        if((email.text?.characters.count)! < 5){
            email.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            return false
        }else {
            email.backgroundColor = UIColor.white
            
            
            
        }
        
        if((password.text?.characters.count)! < 5){
            password.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            return false
        }else {
            password.backgroundColor = UIColor.white
            
            
            
        }
        
        
        if((name.text?.characters.count)! < 2){
            name.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            return false
        }else {
            name.backgroundColor = UIColor.white
            
            
            
        }
        
        if((mobile.text?.characters.count)! < 11){
            mobile.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            return false
        }else {
            mobile.backgroundColor = UIColor.white
            
            
            
        }
        
        if(!self.CheckBloodGroup()){
            bloodGroup.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            bloodGroup.text = ""
            bloodGroup.placeholder = "Invalid Blood group"
            return false
        }else {
            bloodGroup.backgroundColor = UIColor.white
            
            
            
        }
        
        return true
        
    }
    
//    func SendMessage(data: [String: String]){
//        
//        
//        //let uid = FIRAuth.auth().u
//        
//        if let toText: String = toTextBox.text {
//            let to = createNewEmail(oldEmail: toText)
//            if let user = FIRAuth.auth()?.currentUser?.email{
//                var packet = data
//                packet[Constants.MessageFields.dateTime] = Utilities().GetDate()
//                packet[Constants.MessageFields.sender] = user
//                self.ref.child(to).childByAutoId().setValue(packet)
//            }
//        }
//    }
    
//    func saveInMessage() -> Void {
//        let emailString = self.email.text!
//        
//        let newemail = self.createNewEmail(oldEmail: emailString)
//        self.ref.child("Messages").child(newemail).setValue(nil)
//    
//    }
    
    func saveInUser() -> Void {
        let emailString = self.email.text!
        
        let newemail = self.createNewEmail(oldEmail: emailString)
        
        var data = [Constants.UserDetails.name: self.name.text! as String]
        data[Constants.UserDetails.mobile] = self.mobile.text!
        data[Constants.UserDetails.bloodGroup] = self.bloodGroup.text!
        data[Constants.UserDetails.city] = self.city.text!
        self.ref.child("UserDetails").child(newemail).setValue(data)
        
        print("saved user details")
        
    }
    
    func saveInBloodGroup() -> Void {
        let bg = GetBloodGroup()
        var data = [Constants.BloodGroup.email: self.email.text! as String]
        data[Constants.BloodGroup.mobile] = self.mobile.text!
        self.ref.child("BloodGroups-User").child(bg).childByAutoId().setValue(data)
    }
    
    

    @IBAction func submit(_ sender: Any) {
        
        if(!CheckInput()){
            
            return
            
        }
        
        let alert = UIAlertController(title: "Register" , message: "Please confirm password...", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil ) )
        
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:
            {
                (action) -> Void in
                let passConfirm = alert.textFields![0] as UITextField
                if (passConfirm.text!.isEqual(self.password.text!)){
                    //reg begins
                    let email = self.email.text
                    let password = self.password.text
                    
                    
                    FIRAuth.auth()?.createUser(withEmail: email!, password: password!, completion:
                        {
                            (user,error) in
                            if let error = error {
                                Utilities().ShowAlert(title: "Error" , message: error.localizedDescription , vc: self)
                                return
                            }
                            else{
                                print("Successfully created user. Here I can save other data")
                                self.saveInUser()
                                self.saveInBloodGroup()
                                //self.saveInMessage()
                                
                                
                                
                                
                                
                                
                                
                            }
                            self.dismiss(animated:true,completion:nil)
                    })
                }
                    
                else {
                    Utilities().ShowAlert(title: "Error", message: "Password not the same", vc: self)
                    
                }
        }
            
        ))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
