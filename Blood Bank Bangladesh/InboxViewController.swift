//
//  InboxViewController.swift
//  Blood Bank Bangladesh
//
//  Created by Ahnaf on 5/3/17.
//  Copyright © 2017 Ahnaf. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class InboxViewController: UITableViewController {
    var index = 0
    var messages: [FIRDataSnapshot]! = [FIRDataSnapshot]()
    
    var ref: FIRDatabaseReference?
    var databaseHandle: FIRDatabaseHandle?
    
    var phoneNumber = String()
    var messageDetail = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        FetchData()
        
        
        
    }
    
    deinit{
        self.ref?.child("messages").removeObserver(withHandle: databaseHandle!)
        
    }
    
    
    func FetchData(){
        //get current user email
        let currEmail = FIRAuth.auth()?.currentUser?.email!
        //print(currEmail)
        let newemail = Utilities().createNewEmail(oldEmail: currEmail!)
        
        
        
        ref = FIRDatabase.database().reference()
        databaseHandle = self.ref?.child("Messages").child(newemail).observe(.childAdded,with: {
            (snapshot) -> Void in
            self.messages.append(snapshot)
            self.tableView.insertRows(at: [IndexPath(row: self.messages.count-1,section:0)], with: .automatic)
            
        })
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messages.count
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        
        
        let messageSnap: FIRDataSnapshot! = self.messages[indexPath.row]
        let message = messageSnap.value as! Dictionary<String , String>
        if let text = message[Constants.RequestMessage.sender] as String! {
            cell.textLabel?.text = text
        }
        
        if let subText = message[Constants.RequestMessage.message]{
            cell.detailTextLabel?.text = subText
            
        }
        
        
        return cell
    }
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        
        let currentcell = tableView.cellForRow(at: indexPath)
        
        phoneNumber = (currentcell?.textLabel?.text)!
        messageDetail = (currentcell?.detailTextLabel?.text)!
        
        let newVC: MDVC = MDVC()
        newVC.passnumber = phoneNumber
        newVC.passmessage = messageDetail
        
//        self.present(newVC, animated: true, completion: nil)
//        //self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "MDsegue", sender: self)
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier{
            if(id == "MDsegue"){
                let newVC = segue.destination as! MDVC
                newVC.passnumber = phoneNumber
                newVC.passmessage = messageDetail
                
                
                //newVC.messagelbl.text = messageDetail
                //newVC.numberlbl.text = phoneNumber
                
                
            }
        }
    }
    
}
