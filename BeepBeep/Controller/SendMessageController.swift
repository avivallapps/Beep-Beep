//
//  SendMessageController.swift
//  BeepBeep
//
//  Created by Aviv Dimri on 12/12/2018.
//  Copyright © 2018 Aviv Dimri. All rights reserved.
//

import UIKit
import Firebase

class SendMessageController: UITableViewController {

    let cellId = "cellId"
    var messages = [Message]()
    var messages2 = [Message]()
    var tempoUserId: String?
    var tempoName: String?
    var checkit: String?
    
    var yesornot: String?
   // var thetitle: String?
    
    //var refreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl!.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl!)
   //     self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.tableView.tableFooterView = UIView()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
       // thetitle = UIColor.blue
       // navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "Aviv", size: 20)!]
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.lightGray]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.title = "Incoming Messages"
        
        
        tableView.register(MessageCell.self, forCellReuseIdentifier: cellId)
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        
     //   navigationItem.rightBarButtonItem = UIBarButtonItem(title: "edit", style: .plain, target: self, action: #selector(handledit))
      //  self.tableView.tableFooterView = [UIView, new]

        
        fetchUser()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
            self.reverseList()
        })
        
        
        
    }
    
    func reverseList(){
        print("hiiiiiii")
        messages.reverse()
        tableView.reloadData()
        
    }
    @objc func refresh(_ sender: Any){
       self.messages.removeAll()
       self.tableView.reloadData()
       fetchUser()
       
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
     //       self.tableView.reloadData()
            self.reverseList()
            
        })

        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.refreshControl?.endRefreshing()
        })
        
    }
    
    func turnstarttoend(messaggge: [Message]){
        for i in stride(from: messaggge.count, to: 0, by: messaggge.count-1) {
            messages2 = [messaggge[i]]
        }
        
    }
    
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let item = messages[sourceIndexPath.row]
//        messages.remove(at: sourceIndexPath.row)
//        messages.insert(item, at: destinationIndexPath.row)
//    }
//
//    @objc func handledit(_ sender: Any){
//        tableView.isEditing = !tableView.isEditing
//
//        switch tableView.isEditing {
//        case true:
//            navigationItem.rightBarButtonItem?.title = "done"
//        case false:
//            navigationItem.rightBarButtonItem?.title = "edit"
//        }
//    }
    func fetchUser(){
         let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("Messages").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                print(12223)
                //if you use this setter your app will crash if your class propetties dont extacly match up with the firsebase dicitonry keys
                
                
                //user.setValuesForKeys(dictionary)
                self.tempoUserId = dictionary["sender"] as? String
              //  print(self.tempoUserId)
                
        
                    
//                    Database.database().reference().child("Users").child(self.tempoUserId!).observeSingleEvent(of: .value, with: { (snapshot2) in
//                        //  print(snapshot2)
//                        //if snapshot2.hasChild(self.tempoUserId!){
//
//                        if let dictionary2 = snapshot2.value as? [String: AnyObject] {
//
//                            // print(snapshot2)
//                            //  print(123)
//                            print(dictionary2)
//
//                            self.tempoName = dictionary2["name"] as? String
//                            print("nisayon " + self.tempoName!)
//
//                            // }
//                        }
//                    })
//
                
                
                
                
                print(555)
                
               // print("11 " + self.tempoName!)
                let message = Message()
                message.name = dictionary["name"] as? String
                message.message = dictionary["message"] as? String
                self.checkit = dictionary["reciver"] as? String
                message.checkyes = dictionary["check"] as? String
                message.key = dictionary["keyId"] as? String
                //self.yesornot = dictionary["check"] as? String
                
                if uid == self.checkit{
                    self.messages.append(message)

                }else{

                }
                //this will crash because of background thread, so ets use dispatch_async to fix
                
                
            //    DispatchQueue.main.async {
             //       self.tableView.reloadData()
              //  }
                
                //dispatch_queue_main_t.self
                
                //                user.name = dictionary["name"]
                //                print(user.name, user.email)
                
            }
            //            print("User found")
            //            print(snapshot)
            
        }, withCancel: nil)
      //  messages.reverse()
        
    }
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        print("hi checking if can delete")
      
       // if editingStyle == .delete {
          //  messages.remove(at: indexPath.row)
            
         //   tableView.deleteRows(at: [indexPath], with: .fade)
     //   }
        
        
        
        
     //   if editingStyle == UITableViewCell.EditingStyle.delete {
      //      messages.remove(at:  indexPath.row)
       //     tableView.reloadData()
       // }
        
        print(messages[indexPath.row])
        
        
        
   //     guard let uid = Auth.auth().currentUser?.uid else{
     //       return
      //  }
        
        let message = messages[indexPath.row]
        
    //    print("this is the message key: " + message.key!)
        
        if let keyId = message.key {
            Database.database().reference().child("Messages").child(keyId).removeValue { (error, ref) in
                if error != nil {
                    print("Failed to delete message:" , error!)
                    return
                }
                print("hi checking if can delete22")
                self.messages.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                
            }
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let use a hack for now
        //   let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
    
        print("bdika mispar 111111111")
        
        let message = messages[indexPath.row]
        cell.textLabel?.text = "From: " + message.name!
        cell.detailTextLabel?.text = message.message
        
       // print(yesornot)
        if message.checkyes == "yes" {
            print("trying this one")
            cell.accessoryView = UIImageView(image:UIImage(named: "chat")!)
            
//            let ref = FIRDatabase.database().reference().root.child("Messages").child(uid).updateChildValues(["Places": "no"])
            
            
             let ref3 = Database.database().reference().child("Messages")
            ref3.observeSingleEvent(of: .value) { (snapshot) in
                if let result = snapshot.children.allObjects as? [DataSnapshot] {
                    for child in result {
                        if child.childSnapshot(forPath: "check").value as? String == "yes" {
                            let childKey = child.key
                            ref3.child(childKey).child("check").setValue("no")
                        }
                    }
                }
            }
            
        } else {
            cell.accessoryView = nil
        }
       
        
        //cell.accessoryType = .disclosureIndicator
        
   //     cell.separatorInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return cell
    }
    
    
}

class MessageCell: UITableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
