//
//  SettingsViewController.swift
//  BeepBeep
//
//  Created by Aviv Dimri on 20/01/2019.
//  Copyright © 2019 Aviv Dimri. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UITableViewController {
    
    let cellId = "cellId"
    var liness = ["Tutorial","About","Logout"]
    
    var tempoUserId: String?
    var tempoName: String?
    var checkit: String?
    var myCarNumber: String?
    
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "Bla bla bla"
        tv.isEditable = false
        tv.font = UIFont.boldSystemFont(ofSize: 22)
        //tv.font = tv.font?.withSize(30)
        tv.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        // tv.contentInset = UIEdgeInsets(top: -4, left: -8, bottom: 0, right: 0)
        tv.contentMode = .scaleToFill
    //    tv.textColor = .white
        return tv
    }()
    
    let TutorialButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.white
        //button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("Tutorial", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        // button.layer.borderColor = UIColor.black as! CGColor
        
        button.addTarget(self, action: #selector(handleTutorial), for: .touchUpInside )
        
        return button
    }()
    
    @objc func handleTutorial(){
        let checkviewcontroller = CheckViewController()
        let navController = UINavigationController(rootViewController: checkviewcontroller)
        present(navController,animated: true, completion: nil)
    }

    let LogoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.white
        //button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("Logout", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        // button.layer.borderColor = UIColor.black as! CGColor
        
           button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside )
        
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none

       
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.lightGray]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.title = "Settings"
        
        view.addSubview(TutorialButton)
        view.addSubview(LogoutButton)
        view.addSubview(textView)
        
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        
        
        setupTutorialButton()
        setupLogoutButton()
       // setupTextView()
        
        _ = textView.anchor(LogoutButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 50, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 40)
        
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        fetchUser()
    }

    func setupLogoutButton(){
        
        LogoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        LogoutButton.topAnchor.constraint(equalTo: TutorialButton.bottomAnchor, constant: 15).isActive = true
        
        LogoutButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
        
        LogoutButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    func setupTutorialButton(){
        //need x, y , wifth, height, constraints
        
        TutorialButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        TutorialButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        
        TutorialButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
        
        TutorialButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    func fetchUser(){
        let uid = Auth.auth().currentUser?.uid

        
        tempoUserId = ""
        Database.database().reference().child("Users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            print("helloall")

            if let dictionary = snapshot.value as? [String: AnyObject] {
                print(12223)
                //if you use this setter your app will crash if your class propetties dont extacly match up with the firsebase dicitonry keys
                
                
                //user.setValuesForKeys(dictionary)
               // self.tempoUserId = dictionary["carnumber"] as? String
                
                self.tempoUserId = self.getCarNumber(uid: uid!)
                
                if let tempoName = dictionary["carnumber"] {
                   // self.checkit = tempoName as? String
                    self.textView.text = "Your car number:    " + (tempoName as! String)

                  //  print(tempoName)
                } else {
                    print("error")
                }
               // print(dictionary)
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
//                let message = Message()
//                message.name = dictionary["name"] as? String
//                message.message = dictionary["message"] as? String
//                self.checkit = dictionary["reciver"] as? String
//                message.checkyes = dictionary["check"] as? String
//                //self.yesornot = dictionary["check"] as? String
//
//                if uid == self.checkit{
//                    self.messages.append(message)
//
//                }else{
//
//                }
                //this will crash because of background thread, so ets use dispatch_async to fix
                
            //    print(self.tempoUserId)

                
         //    DispatchQueue.main.async {
             //       self.tableView.reloadData()
               // }
                
                //dispatch_queue_main_t.self
                
                //                user.name = dictionary["name"]
                //                print(user.name, user.email)
                
            }
            //            print("User found")
            //            print(snapshot)
            
        }, withCancel: nil)
        
    }
    
    
    
    
    
    
//    func setupTextView(){
//        //need x, y , wifth, height, constraints
//
//        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//
//        textView.topAnchor.constraint(equalTo: LogoutButton.bottomAnchor, constant: 20).isActive = true
//
//        textView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
//
//        textView.heightAnchor.constraint(equalToConstant: 60).isActive = true
//
//    }

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return liness.count
//    }
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//       // let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
//
//       // cell.textLabel?.text = "balalalalal"
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
//
//        let lines = liness[indexPath.row]
//        cell.textLabel?.text = lines
////
////        let message = messages[indexPath.row]
////        cell.textLabel?.text = "From: " + message.name!
////        cell.detailTextLabel?.text = message.message
//
//        return cell
//
//    }

    
    func  getCarNumber(uid: String?) -> String{
        myCarNumber = ""
    //    let ref = Database.database().reference()
        
        Database.database().reference().child("Users").observeSingleEvent(of: .value, with: { (snapshot) in
            
            //if let dictionary = snapshot.value as? [String: AnyObject] {
            //  self.navigationItem.title = dictionary["name"] as? String
            if snapshot.hasChild(uid!){
                
                if let dictionary = snapshot.childSnapshot(forPath: uid!).value as? [String: AnyObject] {
                    // print(snapshot)
                    //  print(123)
                    //print(dictionary)
                    self.myCarNumber = dictionary["name"] as? String
                    
                    if let tempoName = dictionary["name"] {
                        self.checkit = tempoName as? String
                        print(tempoName)
                    } else {
                        print("error")
                    }
                  //  print(dictionary["name"] as? String)
                    
                }
            }
        })
     //   print("helloall")
      //  print(self.myCarNumber ?? nil)
      //  print(self.checkit)
        return myCarNumber!
        
    }
    
    @objc func handleCancel(){
        dismiss(animated: true,completion: nil)
    }
    
    @objc func handleLogout(){
        do{
            try Auth.auth().signOut()
            
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginController = LoginController()
        present(loginController,animated: true, completion: nil)
    }

}
