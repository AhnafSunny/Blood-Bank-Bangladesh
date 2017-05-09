//
//  MDVC.swift
//  Blood Bank Bangladesh
//
//  Created by Ahnaf on 5/5/17.
//  Copyright © 2017 Ahnaf. All rights reserved.
//

import UIKit
import QuartzCore

class MDVC: UIViewController {
    @IBOutlet weak var messagelbl: UILabel!
    @IBOutlet weak var numberlbl: UILabel!
    
    var passnumber = "NULL"
    var passmessage = "NULL"

    override func viewDidLoad() {
        super.viewDidLoad()
        messagelbl.text = passmessage
        numberlbl.text = passnumber
        
        messagelbl.layer.cornerRadius = 15
        messagelbl.layer.masksToBounds = true
        
        numberlbl.layer.cornerRadius = 15
        numberlbl.layer.masksToBounds = true
        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func call_button_pressed(_ sender: Any) {
        
        
        if let number = numberlbl.text{
            if let phoneURL = NSURL(string: "tel://\(number)"){
                    UIApplication.shared.open(phoneURL as URL, completionHandler: nil)
            }
        }
        
        
    }

    
}
