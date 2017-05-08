//
//  MDVC.swift
//  Blood Bank Bangladesh
//
//  Created by Ahnaf on 5/5/17.
//  Copyright © 2017 Ahnaf. All rights reserved.
//

import UIKit

class MDVC: UIViewController {
    @IBOutlet weak var messagelbl: UILabel!
    @IBOutlet weak var numberlbl: UILabel!
    
    var passnumber = "NULL"
    var passmessage = "NULL"

    override func viewDidLoad() {
        super.viewDidLoad()
        //messagelbl.text = passmessage
        //numberlbl.text = passnumber
        
        print("new VC")
        print(passnumber)
        print(passmessage)
        
        messagelbl.text = passmessage
        numberlbl.text = passnumber
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func call_button_pressed(_ sender: Any) {
        
        print("call pressed")
        if let number = numberlbl.text{
            if let phoneURL = NSURL(string: "tel//\(number)"){
                    UIApplication.shared.open(phoneURL as URL, completionHandler: nil)
            }
        }
        
        
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
