//
//  LoginController.swift
//  BeepBeep
//
//  Created by Aviv Dimri on 03/12/2018.
//  Copyright © 2018 Aviv Dimri. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    let inputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside )
        
        return button
    }()
    
   @objc func handleLoginRegister(){
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        }else{
            handleRegister()
        }
    }
    @objc func handleLogin(){
        guard let email = emailTextField.text, let password = passwordTextField.text
            else {
                print("Form is not valid")
                return
        }
        
        print("hello all")

        Auth.auth().signIn(withEmail: email, password: password) { (User, error) in
            if error != nil {
                print(error!)
                return
            }
        
            print("avivtheking")
            let maincontroller = MainController()
            let navController = UINavigationController(rootViewController: maincontroller)
            self.present(navController,animated: true, completion: nil)
            //self.dismiss(animated: true, completion: nil)
          
        }
        
        
    }
    
    @objc func handleRegister(){
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text, let carnumber = carnumberTextField.text
            else {
                print("Form is not valid")
                return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (User, error) in
            if error != nil {
                print(error!)
                return
            }

            guard let uid = User?.uid else {
                return
            }
            //susscufulyl authentication user
            let ref = Database.database().reference(fromURL: "https://beepbeep-1e7da.firebaseio.com/")
            let usersReference = ref.child("Users").child(uid)
            let usersReference2 = ref.child("CarNumbers").child(carnumber)
            
            let values = ["name": name, "email": email,"carnumber": carnumber]
            let values2 = ["name": name, "email": email, "user_id": uid]
            usersReference2.updateChildValues(values2, withCompletionBlock: { (error, ref) in
                if error != nil {
                    print(error!)
                    return
                }
            })
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print(err!)
                    return
                }
                let checkviewcontroller = CheckViewController()
                let navController = UINavigationController(rootViewController: checkviewcontroller)
                self.present(navController,animated: true, completion: nil)
               // self.dismiss(animated: true, completion: nil)
                print("Saved user successfully into Firebase db")
            })
           // ref.updateChildValues(["someValue": 123123])
        }
        print(123)
    
    }
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    let nameSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220,g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220,g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let carnumberSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220,g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    let carnumberTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "carnumber"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let profileImageView: UIImageView = {
       let imageView = UIImageView ()
        imageView.image = UIImage(named: "stop-sign")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
        
        
    }()
    
    let loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return sc
    }()
    
    @objc func handleLoginRegisterChange(){
    
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
      
        loginRegisterButton.setTitle(title, for: .normal)
    
        print(loginRegisterSegmentedControl.selectedSegmentIndex)
        
        //change height of input containerview
        inputsContainerViewHeightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 200
        
        //change height of nametextfield
        nameTextFieldHeightAnchor?.isActive = false
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor,multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/4)
        nameTextFieldHeightAnchor?.isActive = true
        
        emailTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor,multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/4)
        emailTextFieldHeightAnchor?.isActive = true
        
        passwordTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor,multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/4)
        passwordTextFieldHeightAnchor?.isActive = true
        
        
        carnumberTextFieldHeightAnchor?.isActive = false
        carnumberTextFieldHeightAnchor = carnumberTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor,multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/4)
        carnumberTextFieldHeightAnchor?.isActive = true
    
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
       // view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        
        
//        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
//        if launchedBefore  {
//            print("Not first launch.")
//        }
//        else {
//            print("First launch, setting NSUserDefault.")
//            UserDefaults.standard.set(true, forKey: "launchedBefore")
//            
//            let checkviewcontroller = CheckViewController()
//            let navController = UINavigationController(rootViewController: checkviewcontroller)
//            self.present(navController,animated: true, completion: nil)
//            
//            
//        }
        
        
        
        view.addSubview(inputContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(profileImageView)
        view.addSubview(loginRegisterSegmentedControl)
        
    
        setupInputsContainerView()
        setupLoginRegisterButton()
        setupProfileImageView()
        setupLoginRegisterSegmentedControl()
        
    }
    
    func setupLoginRegisterSegmentedControl(){
        //need x, y , wifth, height, constraints

        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: -12).isActive = true
        
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor, multiplier: 1).isActive = true
        
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 36).isActive = true



    }
    func setupProfileImageView(){

        //need x, y , wifth, height, constraints
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        profileImageView.bottomAnchor.constraint(equalTo: loginRegisterSegmentedControl.topAnchor, constant: -12).isActive = true

        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true

        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true


    }
    
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    var carnumberTextFieldHeightAnchor: NSLayoutConstraint?
    
    
    func setupInputsContainerView(){
          //need x, y , wifth, height, constraints
        inputContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        
        
        inputsContainerViewHeightAnchor = inputContainerView.heightAnchor.constraint(equalToConstant: 200)
            inputsContainerViewHeightAnchor?.isActive = true
   
    
        inputContainerView.addSubview(nameTextField)
        inputContainerView.addSubview(nameSeperatorView)
        inputContainerView.addSubview(emailTextField)
        inputContainerView.addSubview(emailSeperatorView)
        inputContainerView.addSubview(passwordTextField)
        inputContainerView.addSubview(carnumberSeperatorView)
        inputContainerView.addSubview(carnumberTextField)
            //need x, y , wifth, height, constraints

        nameTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputContainerView.topAnchor).isActive = true
        
        nameTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor,  multiplier: 1/4)
            
        nameTextFieldHeightAnchor?.isActive = true
        
        //need x, y , wifth, height, constraints
        nameSeperatorView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        
        nameSeperatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        
        nameSeperatorView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        
        nameSeperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //need x, y , wifth, height, constraints
        
        emailTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        
        emailTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor,  multiplier: 1/4)
        emailTextFieldHeightAnchor?.isActive = true
        
        //need x, y , wifth, height, constraints
        emailSeperatorView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        
        emailSeperatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        
        emailSeperatorView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        
        emailSeperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        //need x, y , wifth, height, constraints
        
        passwordTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        
        passwordTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor,  multiplier: 1/4)
        passwordTextFieldHeightAnchor?.isActive = true
        
        //need x, y , wifth, height, constraints
        
        carnumberSeperatorView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        
        carnumberSeperatorView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        
        carnumberSeperatorView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        
        carnumberSeperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        ///
        
        carnumberTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        carnumberTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        
        carnumberTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        
        carnumberTextFieldHeightAnchor = carnumberTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor,  multiplier: 1/4)
        carnumberTextFieldHeightAnchor?.isActive = true
        
        //need x, y , wifth, height, constraints
        
    }
    
    func setupLoginRegisterButton(){
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
    }
    

    func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .lightContent
    }
}
extension UIColor {
    convenience init (r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
