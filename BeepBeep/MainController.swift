//
//  ViewController.swift
//  BeepBeep
//
//  Created by Aviv Dimri on 03/12/2018.
//  Copyright © 2018 Aviv Dimri. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation


class MainController: UITableViewController {
    
    var otherUserId: String?
    var otherUsername: String?
    var myUserName: String?
    var myUserName3: String?
    var myUserName5: String?
    
    
    var messages = [Message]()
    var messages2 = [Message]()
    var tempoUserId: String?
    var tempoName: String?
    var checkit: String?
    
    var checkthat = "nope"
    
    var yesornot: String?
    
    var player: AVAudioPlayer?
    
    var mmm = "no"

    let inputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()

    var badeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.backgroundColor = .red
        return view
    }()
    
    let searchTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "enter car number"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    
    
    let carImageView: UIImageView = {
        let imageView = UIImageView ()
        imageView.image = UIImage(named: "carwow")
        imageView.layer.cornerRadius = 4
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
      //  imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.white
        imageView.layer.cornerRadius = 55
        //   imageView.layer.masksToBounds = false
       // imageView.layer.cornerRadius = imageView.frame.size.width/2
       // imageView.layer.cornerRadius = imageView.frame..sizewidth/2
        imageView.clipsToBounds = true

        
       // imageView.layer.frame = CGRect.insetBy(imageView.layer.frame, 0, 0)
       // imageView.layer.borderWidth = 1
       // imageView.layer.borderColor = UIColor.black.cgColor
        

        //imageView.clipsToBounds = true
        
        
        //imageView.makeRounded()
//        imageView.layer.borderWidth = 1
//        imageView.layer.masksToBounds = false
//        imageView.layer.borderColor = UIColor.black.cgColor
//        imageView.clipsToBounds = true
        return imageView
        
        
    }()

    let SearchButton: BounceButton = {
        let button = BounceButton(type: .system)
        button.backgroundColor = UIColor.white
        //button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("Search!", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.setTitleColor(UIColor.blue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
       // button.layer.borderColor = UIColor.black as! CGColor
        
        button.addTarget(self, action: #selector(handleSearch), for: .touchUpInside )
        
        return button
    }()
    
    @objc func handleSearch(){
        guard let search = searchTextField.text
            else {
                print("Form is not valid")
                return
        }
        let ref = Database.database().reference()
        let uid = Auth.auth().currentUser!.uid
       
       print(0909)
        if(search != ""){
        Database.database().reference().child("CarNumbers").observeSingleEvent(of: .value, with: { (snapshot) in
            
            //if let dictionary = snapshot.value as? [String: AnyObject] {
              //  self.navigationItem.title = dictionary["name"] as? String
            if snapshot.hasChild(search){
                
                if let dictionary = snapshot.childSnapshot(forPath: search).value as? [String: AnyObject] {
                   // print(snapshot)
                   print(123)
                    //print(dictionary)
                    self.otherUserId = dictionary["user_id"] as? String
                    //self.otherUsername = dictionary["name"] as? String
                    
                }
                
                self.myUserName = self.getUsername(uid: uid)
                
                let theKey = ref.child("Messages").childByAutoId().key
               // let usersReference = ref.child("Messages").child(self.otherUserId!)
                let  usersReference2 = ref.child("Messages").child(theKey)
            //    let  usersReference2 = ref.child("Messages").childByAutoId().key

            print("yes")
                let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
                
                
                alert.addAction(UIAlertAction(title: "You forgot a Baby in the car", style: UIAlertAction.Style.destructive, handler: { action in
                    let value = ["message": "You forgot a Baby in the car","sender": uid, "reciver": self.otherUserId!,"name": self.myUserName,"check": "yes","keyId": theKey]
                    
                    
                    usersReference2.updateChildValues(value as [AnyHashable : Any],withCompletionBlock:{ (error, ref) in
                        if error != nil {
                        print(error!)
                        return
                        }
                        })
                    
                 //   self.mmm = "yes"
                    
                  
               //     DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                //        self.poptheusername(username: self.myUserName)
                 //   })
                    
                    
              
//                    alert.dismiss(animated: true, completion: nil)
                  let popitup = PopItUp()
//
////                    let = self.myUserName
////
////
                    let navit = UINavigationController()
                    navit.modalPresentationStyle = .overCurrentContext
                    navit.modalTransitionStyle = . crossDissolve
                    self.poptheusername(username: self.myUserName)
                    navit.pushViewController(popitup, animated: true)
                 //   navit.show(popitup, sender: self)
                    self.present(navit,animated: true,completion: nil)
                }))
                
                
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            //    alert.addAction(UIAlertAction(title: "Launch the Missile", style: UIAlertAction.Style.destructive, handler: nil))
                alert.addAction(UIAlertAction(title: "Your car window is open", style: UIAlertAction.Style.default, handler: { action in
                    let value = ["message": "Your car window is open","sender": uid, "reciver": self.otherUserId!,"name": self.myUserName,"check": "yes","keyId": theKey]
                    
                    usersReference2.updateChildValues(value as [AnyHashable : Any],withCompletionBlock:{ (error, ref) in
                        if error != nil {
                            print(error!)
                            return
                        }
                    })
                    
                    let popitup = PopItUp()
                 
                    let navit = UINavigationController()
                    navit.modalPresentationStyle = .overCurrentContext
                    navit.modalTransitionStyle = . crossDissolve
                    self.poptheusername(username: self.myUserName)
                    navit.pushViewController(popitup, animated: true)
                    self.present(navit,animated: true,completion: nil)
                }))
                    
                
                
                alert.addAction(UIAlertAction(title: "You are parking in forbidden area", style: UIAlertAction.Style.default, handler: { action in
                    let value = ["message": "You are parking in forbidden area","sender": uid, "reciver": self.otherUserId!,"name": self.myUserName,"check": "yes","keyId": theKey]
                    
                    usersReference2.updateChildValues(value as [AnyHashable : Any],withCompletionBlock:{ (error, ref) in
                        if error != nil {
                            print(error!)
                            return
                        }
                    })
                    
                    let popitup = PopItUp()
                    
                    let navit = UINavigationController()
                    navit.modalPresentationStyle = .overCurrentContext
                    navit.modalTransitionStyle = . crossDissolve
                    self.poptheusername(username: self.myUserName)
                    navit.pushViewController(popitup, animated: true)
                    self.present(navit,animated: true,completion: nil)
                    
                }))
                
                
                alert.addAction(UIAlertAction(title: "Move yout car! inspector is here!", style: UIAlertAction.Style.default, handler: { action in
                    let value = ["message": "move you car! inspector is here!","sender": uid, "reciver": self.otherUserId!,"name": self.myUserName,"check": "yes","keyId": theKey]
                    
                    usersReference2.updateChildValues(value as [AnyHashable : Any],withCompletionBlock:{ (error, ref) in
                        if error != nil {
                            print(error!)
                            return
                        }
                    })
                    
                    let popitup = PopItUp()
                    
                    let navit = UINavigationController()
                    navit.modalPresentationStyle = .overCurrentContext
                    navit.modalTransitionStyle = . crossDissolve
                    self.poptheusername(username: self.myUserName)
                    navit.pushViewController(popitup, animated: true)
                    self.present(navit,animated: true,completion: nil)
                    
                }))
                
                
                alert.addAction(UIAlertAction(title: "somebody hit your car", style: UIAlertAction.Style.default, handler: { action in
                    let value = ["message": "somebody hit your car","sender": uid, "reciver": self.otherUserId!,"name": self.myUserName,"check": "yes","keyId": theKey]
                    
                    usersReference2.updateChildValues(value as [AnyHashable : Any],withCompletionBlock:{ (error, ref) in
                        if error != nil {
                            print(error!)
                            return
                        }
                    })
                    
                    let popitup = PopItUp()
                    
                    let navit = UINavigationController()
                    navit.modalPresentationStyle = .overCurrentContext
                    navit.modalTransitionStyle = . crossDissolve
                    self.poptheusername(username: self.myUserName)
                    navit.pushViewController(popitup, animated: true)
                    self.present(navit,animated: true,completion: nil)
                    
                }))
                
                alert.addAction(UIAlertAction(title: "Other", style: UIAlertAction.Style.default, handler: { action in
                    
                    let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                    
                    
                    alert.addTextField(configurationHandler: { (textField) in
                        textField.placeholder = "Enter what you want to send to the Owner of: " + search + " car number"
                    })
                    
                    
                    alert.addAction(UIAlertAction(title: "Send", style: UIAlertAction.Style.default, handler: { action in
                        
                 //   let textField = alert.textFields![0]
                        
                        
                        let textField = alert.textFields?.first?.text
                     //   print(textField)
                        if textField != "" {
                            let value = ["message": textField!,"sender": uid, "reciver": self.otherUserId!,"name": self.myUserName!,"check": "yes"] as [String : Any]
                        
                        usersReference2.updateChildValues(value,withCompletionBlock:{ (error, ref) in
                            if error != nil {
                                print(error!)
                                return
                            }
                        })
                    }
                        
                        let popitup = PopItUp()
                        
                        let navit = UINavigationController()
                        navit.modalPresentationStyle = .overCurrentContext
                        navit.modalTransitionStyle = . crossDissolve
                        self.poptheusername(username: self.myUserName)
                        navit.pushViewController(popitup, animated: true)
                        self.present(navit,animated: true,completion: nil)
                        
                    }))
                   
                    
                    self.present(alert, animated: true, completion: nil)
                    
                }))
                
    
                
                self.present(alert, animated: true, completion: nil)
//                let newSendMessageController = SendMessageController()
//                let navController = UINavigationController(rootViewController: newSendMessageController)
//                self.present(navController,animated: true, completion: nil)
            }else{
                print("not in db")
                print(snapshot)
            }
           // print(snapshot)
        }, withCancel: nil)
        }else {
        print("88888888")
        
        }
    }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        // Do any additional setup after loading the view, typically from a nib.
        
        
        view.backgroundColor = UIColor.lightGray
        
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        
    
  
     
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(goToSettings))
        
        checkNewMessages()
//        print("this is: " + mmm)
//
//        if mmm == "yes"{
//            mmm = "no"
//            poptheusername(username: myUserName)
//        }

        let image = UIImage(named: "notif")
       
       
        //imaged.addSubview(label)
        
        
        
       // image.frame = CGRect(x: 0.0, y: 0.0,width: 20,height: 20)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleNewMessage))
        
        
        navigationItem.title = "BeepBeep"
        
//[self.navigationItem.rightBarButtonItem].badgeValue = 3

        // user is not logged in
        checkIfUserIsLoggedIn()
        view.addSubview(inputContainerView)
        view.addSubview(SearchButton)
        view.addSubview(carImageView)


        setupInputsContainerView()
        setupSearchButton()
        setupCarImageView()
        
       // carImageView.makeRounded()
        
        
        
    }
    
    func setupCarImageView(){
        
        carImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        carImageView.bottomAnchor.constraint(equalTo: searchTextField.topAnchor, constant: -30).isActive = true
        
        carImageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        
        carImageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
    }
    
    func setupSearchButton(){
        //need x, y , wifth, height, constraints
        
        SearchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        SearchButton.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: 15).isActive = true
        
        SearchButton.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor, multiplier: 1/3).isActive = true
        
        SearchButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
    }
    
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var searchTextFieldHeightAnchor: NSLayoutConstraint?


    func setupInputsContainerView(){
        //need x, y , wifth, height, constraints
        inputContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -12).isActive = true
        
        
        inputsContainerViewHeightAnchor = inputContainerView.heightAnchor.constraint(equalToConstant: 50)
        inputsContainerViewHeightAnchor?.isActive = true
        
        
        inputContainerView.addSubview(searchTextField)
        
        searchTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        searchTextField.topAnchor.constraint(equalTo: inputContainerView.topAnchor).isActive = true
        
        searchTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        
        searchTextFieldHeightAnchor = searchTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor)
        
        searchTextFieldHeightAnchor?.isActive = true
        
    }
    
    @objc func poptheusername(username: String?){
     
        let popitup = PopItUp()
        let theotheruserr = username
        
 //       self.myUserName3 = self.getUsername3(uid: uid2) as? String
        
      //  print("this is my name" + (self.myUserName3 as! String))
        popitup.myUserName3 = theotheruserr
        
        //  print(myUserName!)
        //      print("this is my name" + myUserName3! )
        // popitup.otherUserId5 = otherUserId5
        let navit = UINavigationController()
        
        //navit.modalPresentationStyle = .overCurrentContext
        navit.modalPresentationStyle = .pageSheet
        
        navit.modalTransitionStyle = . crossDissolve
        navit.pushViewController(popitup, animated: true)
        present(navit,animated: true,completion: nil)
        
    }
    
    @objc func messagebeensent(username: String?){
  //  @objc func handlemessagebeensent(){
        
       let messagebeensentt = MessageBeenSent()
        let theotheruserr = username
        
        //       self.myUserName3 = self.getUsername3(uid: uid2) as? String
        
        //  print("this is my name" + (self.myUserName3 as! String))
        messagebeensentt.titletxt = theotheruserr
        
        //  print(myUserName!)
        //      print("this is my name" + myUserName3! )
        // popitup.otherUserId5 = otherUserId5
        let navit = UINavigationController()
        
        //navit.modalPresentationStyle = .overCurrentContext
     //   navit.modalPresentationStyle = .pageSheet
        
      //  navit.modalTransitionStyle = . crossDissolve
        navit.pushViewController(messagebeensentt, animated: true)
       present(navit,animated: true,completion: nil)
//        dismiss(animated: true, completion: nil)
        
        
//        let messagebeensent = MessageBeenSent()
//                let navController = UINavigationController(rootViewController: messagebeensent)
//                present(navController,animated: true, completion: nil)
        
    }
    func playSound() {
        guard let url = Bundle.main.url(forResource: "slow-spring-board", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    
    
    
    @objc func handleNewMessage(){
//        let newMainController = NewMainController()
//        let navController = UINavigationController(rootViewController: newMainController)
//        present(navController,animated: true, completion: nil)
        
        let sendMessageController = SendMessageController()
        let navController = UINavigationController(rootViewController: sendMessageController)
        present(navController,animated: true, completion: nil)
        
      //  let popitup = PopItUp(nibName: "balbla", bundle: nil)
    //    let navc = UINavigationController(rootViewController: popitup)
      //  let navc = storyboard?.instantiateViewController(withIdentifier: "PopItUp") as! PopItUp
  //      navc.otherUserId = self.otherUserId
  //      navc.modalPresentationStyle = .overCurrentContext
  //      navc.modalTransitionStyle = .crossDissolve
   //     navc.navigationController?.pushViewController(popitup, animated: true)
    //    present(navc,animated:  true, completion:  nil)
        
        
  //      let uid2 = Auth.auth().currentUser!.uid
       // myUserName3 = ""

     //   print(uid2)
       
        
      //
      //    self.myUserName3 = self.getUsername3(uid: uid2) as? String
        
      //      print("this is my name" + (self.myUserName3 as! String))

      //  print(myUserName!)
  //      print("this is my name" + myUserName3! )
       // popitup.otherUserId5 = otherUserId5
        
        
//
//        let popitup = PopItUp()
//        let otherUserId5 = "barbor"
//
//        popitup.otherUserId5 = otherUserId5
//
//        let navit = UINavigationController()
//        navit.modalPresentationStyle = .overCurrentContext
//        navit.modalTransitionStyle = . crossDissolve
//        navit.pushViewController(popitup, animated: true)
//        present(navit,animated: true,completion: nil)
//
        
        
        
        
   //     navigationController?.modalPresentationStyle = .overCurrentContext
     //   navigationController?.modalTransitionStyle = .crossDissolve
        
     //   popitup.modalPresentationStyle = .overCurrentContext
       // popitup.modalTransitionStyle = .crossDissolve
        
      //  navigationController?.pushViewController(popitup, animated: true)
        
        
        
        //nisayon
//        let popitup = PopItUp()
//
//        let navController = UINavigationController(rootViewController: popitup)
//        navController.modalPresentationStyle = .overCurrentContext
//       navController.modalTransitionStyle = .crossDissolve
//        navController.otherUserId = self.otherUserId
       
        
        //end nisayon
        
        //navController.isKind(of: modally)
        
    //    present(navController,animated: true, completion: nil)
        
    }
    
    
    
    
    @objc func checkIfUserIsLoggedIn(){
    if Auth.auth().currentUser?.uid == nil {
    perform(#selector(handleLogout), with: nil, afterDelay: 0)
    // performSelector(inBackground: #selector(handleLogout), with: nil, afterDelay: 0)
    //handleLogout()
    } else {
        let uid = Auth.auth().currentUser?.uid

    Database.database().reference().child("Users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
        
        //if let dictionary = snapshot.value as? [String: AnyObject] {
        if (snapshot.value as? [String: AnyObject]) != nil {

            //self.navigationItem.title = dictionary["name"] as? String

            
        }
            print(snapshot)
        }, withCancel: nil)
        }
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
    @objc func goToSettings(){
        let settingsviewcontroller = SettingsViewController()
        let navController = UINavigationController(rootViewController: settingsviewcontroller)
        present(navController,animated: true, completion: nil)
    }
    

    func  getUsername(uid: String?) -> String{
        myUserName = ""
     //   let ref = Database.database().reference()
        
        Database.database().reference().child("Users").observeSingleEvent(of: .value, with: { (snapshot) in
            
            //if let dictionary = snapshot.value as? [String: AnyObject] {
            //  self.navigationItem.title = dictionary["name"] as? String
            if snapshot.hasChild(uid!){
                
                if let dictionary = snapshot.childSnapshot(forPath: uid!).value as? [String: AnyObject] {
                    // print(snapshot)
                    //  print(123)
                    //print(dictionary)
                    self.myUserName = dictionary["name"] as? String
                    print(self.myUserName!)
                    
                }
    }
        })
        print("helloall")
        print(myUserName!)
        return myUserName!

    }
    
    
    
    func checkNewMessages(){
        checkthat = "maybe"
        
       // let image333 = UIImage(named: "roshrosh")
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("Messages").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
            //    print(12223)
            
                self.tempoUserId = dictionary["sender"] as? String
            
                
               // print(555)
                if self.checkthat == "maybe" {
                let message = Message()
                message.name = dictionary["name"] as? String
                message.message = dictionary["message"] as? String
                self.checkit = dictionary["reciver"] as? String
                message.checkyes = dictionary["check"] as? String
                //self.yesornot = dictionary["check"] as? String
                
                if uid == self.checkit{
                    self.messages.append(message)
                    if message.checkyes == "yes" {
                        print("checking....there is a new message for you")
                        self.checkthat = "yep"
                        
        //              self.myUserName5 = self.getUsername(uid: uid)
                        self.myUserName5 = message.name
                        
                        //Database.database().reference().child("Messages").removeAllObservers()
                        
                  //  self.messagebeensent(username: self.myUserName5)
                 //
                        
                     //   self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image333, style: .plain, target: self, action: #selector(self.handleNewMessage))
                        
                        }
                    
                }else{
                    
                }
          
                }
                
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
                
                //dispatch_queue_main_t.self
                
                //                user.name = dictionary["name"]
                //                print(user.name, user.email)
                
            }
      
            
        }, withCancel: nil)
        
        
     
  //      print(checkthat)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
         //   print(self.checkthat)
            if self.checkthat == "yep"{
                print("moving to messagebeesent")
                self.playSound()
                self.messagebeensent(username: self.myUserName5)

            }else{
                
            }
        })
    
   //     if self.checkthat == "yep" {
    //        self.myUserName5 = self.getUsername(uid: uid)
   //         messagebeensent(username: self.myUserName5)
  //      }
       // tableView.reloadData()
    }
    
    

}
extension UIImageView {
    
    func makeRounded(){
        let radius = self.frame.size.width/2.0
        self.layer.cornerRadius = radius
      //  self.layer.masksToBounds = true
        self.layer.masksToBounds = true
    }
}
