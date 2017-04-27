//
//  ViewController.swift
//  Blood Bank Bangladesh
//
//  Created by Ahnaf on 4/20/17.
//  Copyright © 2017 Ahnaf. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("Sign In Screen")
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(SignInViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
    }
    
    
    
    func dismissKeyboard(){
        view.endEditing(true)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signinClicked(_ sender: Any) {
        if(!CheckInput()){
            
            return
            
        }
        
        
        let email = emailTextField.text
        let password = passwordTextField.text
        
        FIRAuth.auth()?.signIn(withEmail: email! , password: password! , completion: {(user , error) in
            if let error = error {
                Utilities().ShowAlert(title:"Error",message:error.localizedDescription,vc:self)
                
                print(error.localizedDescription)
                return
            }
            print("signed in!")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "home") as! UITabBarController
            self.present(vc, animated: true, completion: nil)
            
             
            
            
            
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "messageView") as! ViewController
//            
//            let nc = UINavigationController(rootViewController: vc)
//            self.present(nc,animated: true,completion: nil)
            
            
            //var vc = UIViewController()
            
            //            if let sb = self.storyboard{
            //                sb.instantiateViewController(withIdentifier: "messageView")
            //            }
            //            else {
            //                print("ran into error")
            //            }
            //
            //if let vc = (self.storyboard?.instantiateViewController(withIdentifier: "messageView"))!
            
        })
    }

    @IBAction func registerClicked(_ sender: Any) {
    }
    
    func CheckInput() -> Bool {
        
        
        if((emailTextField.text?.characters.count)! < 5){
            emailTextField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            return false
        }else {
            emailTextField.backgroundColor = UIColor.white
            
            
            
        }
        
        if((passwordTextField.text?.characters.count)! < 5){
            passwordTextField.backgroundColor = UIColor.init(red: 0.8, green: 0, blue: 0, alpha: 0.2)
            return false
        }else {
            passwordTextField.backgroundColor = UIColor.white
            
            
            
        }
        
        return true
        
    }
    
    
    
    
    
}

