//
//  NewMainController.swift
//  BeepBeep
//
//  Created by Aviv Dimri on 10/12/2018.
//  Copyright © 2018 Aviv Dimri. All rights reserved.
//

import UIKit
import Firebase

class NewMainController: UITableViewController {
    
    
    
    let cellId = "cellId"
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
        fetchUser()
    }
    func fetchUser(){
        Database.database().reference().child("Users").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                print(12223)
                let user = User()
                //if you use this setter your app will crash if your class propetties dont extacly match up with the firsebase dicitonry keys
                
                
                //user.setValuesForKeys(dictionary)
                user.name = dictionary["name"] as? String
                user.email = dictionary["email"] as? String
                self.users.append(user)
                //this will crash because of background thread, so ets use dispatch_async to fix


                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                //dispatch_queue_main_t.self
               
//                user.name = dictionary["name"]
//                print(user.name, user.email)
                
            }
//            print("User found")
//            print(snapshot)
            
        }, withCancel: nil)
        
    }
    @objc func handleCancel(){
        dismiss(animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let use a hack for now
     //   let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
        return cell
    }
    
}

class UserCell: UITableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
