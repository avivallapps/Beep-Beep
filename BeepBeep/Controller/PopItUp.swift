//
//  PopItUp.swift
//  BeepBeep
//
//  Created by Aviv Dimri on 19/02/2019.
//  Copyright © 2019 Aviv Dimri. All rights reserved.
//

import UIKit
import Firebase

class PopItUp: UIViewController {
    
    var otherUserId5: String?
    var myUserName3: String?

    lazy var ddd: UIVisualEffectView = {
        let visualeffect = UIVisualEffectView()
  //      visualeffect.backgroundColor = UIColor.white
        visualeffect.translatesAutoresizingMaskIntoConstraints = false;
        visualeffect.layer.cornerRadius = 5
        visualeffect.layer.masksToBounds = true
        return visualeffect
    }()
    
    let matchLabel: UILabel = {
        let label = UILabel()
        label.text = "Aviv, your message has been sent to shlomi."
        label.numberOfLines = 0
    //    label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping

        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false;

        
       // label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
   
    let inputContainerView: UIView = {
        let view = UIView()
      //  view.backgroundColor = UIColor.white
        view.backgroundColor = UIColor.darkGray
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    let inputContainerView2: UIView = {
        let view2 = UIView()
      //  view2.backgroundColor = UIColor.white
        view2.backgroundColor = UIColor.darkGray
        view2.translatesAutoresizingMaskIntoConstraints = false;
        view2.layer.cornerRadius = 50
        view2.layer.masksToBounds = true
        return view2
    }()
    
    let theButton: UIButton = {
        let button = UIButton(type: .system)
   //     button.backgroundColor = UIColor.white
        //button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
  //     button.setTitle("Search!", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.setTitleColor(UIColor.blue, for: .normal)
    //    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    //    button.layer.cornerRadius = 5
     //   button.layer.borderWidth = 1
        // button.layer.borderColor = UIColor.black as! CGColor
        
       button.addTarget(self, action: #selector(handleTheButton), for: .touchUpInside )
        
        return button
    }()
    
    @objc func handleTheButton(){

        
       // let maincont = MainController()
       // self.navigationController?.pushViewController(maincont, animated: true)
        print("walllllak")
       navigationController?.popViewController(animated: true)
      //  navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    
    }
    
    let popImage: UIImageView = {
        let imageView = UIImageView ()
        imageView.image = UIImage(named: "messagesent")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
        
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
      // view.isOpaque = false
       
        
        //view.backgroundColor  = .clear
         view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        
       // view.addSubview(inputContainerView)

    
    //    UIBlurEffect  = UIBlurEffect(style: .light)
       // ddd = view
     //   setupdddd()
        
        print("whatsauppp")
        let effect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: effect)
        
        blurView.frame = self.view.bounds
        
       // theButton.frame = self.view.bounds
        
        
        
      //  setupthebutton()
        view.addSubview(blurView)
        view.addSubview(theButton)
        view.addSubview(inputContainerView)
        view.addSubview(inputContainerView2)
     //   blurView.addSubview(inputContainerView)
    
        //ddd.addSubview(view)
       // ddd.backgroundColor = .clear
        //ddd.addSubview(inputContainerView)
      //  view.backgroundColor = .clear
       // view.addSubview(inputContainerView)


        setupthebutton()
        setupInputsContainerView()
        setupInputsContainerView2()
        
        
        setthetext()
    }
    
    var dddHeightAnchor: NSLayoutConstraint?

    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    
    var inputsContainerView2HeightAnchor: NSLayoutConstraint?
    
   // var nameTextFieldHeightAnchor: NSLayoutConstraint?
   // var emailTextFieldHeightAnchor: NSLayoutConstraint?
  //  var passwordTextFieldHeightAnchor: NSLayoutConstraint?
   // var carnumberTextFieldHeightAnchor: NSLayoutConstraint?
    
    
    func setupInputsContainerView(){
        //need x, y , wifth, height, constraints
        inputContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30).isActive = true
        
        
        inputsContainerViewHeightAnchor = inputContainerView.heightAnchor.constraint(equalToConstant: 220)
        inputsContainerViewHeightAnchor?.isActive = true
        
        inputContainerView.addSubview(matchLabel)
        
        
      //  matchLabel.centerXAnchor.constraint(equalTo: inputContainerView.centerXAnchor).isActive = true
        
      //  matchLabel.centerYAnchor.constraint(equalTo: inputContainerView.centerYAnchor).isActive = true
        
        matchLabel.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor, constant: 5).isActive = true
        
        matchLabel.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor,constant: 5).isActive = true
        
//        matchLabel.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 0).isActive = true
//        matchLabel.topAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: 0).isActive = true
//
//        matchLabel.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
//
//        matchLabel.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, constant: 0).isActive = true
     //   nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor,  multiplier: 1/4)
        
   //     nameTextFieldHeightAnchor?.isActive = true
        
   //     inputContainerView.addSubview(theButton)
    //    //need x, y , wifth, height, constraints
//    //    theButton.centerXAnchor.constraint(equalTo: inputContainerView.centerXAnchor).isActive = true
//        theButton.centerYAnchor.constraint(equalTo: inputContainerView.centerYAnchor).isActive = true
//        theButton.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
//        theButton.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor).isActive = true
        
       

    }
    
    func setupInputsContainerView2(){
        //need x, y , wifth, height, constraints

        inputContainerView2.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: 50).isActive = true
  
        
        inputContainerView2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        inputContainerView2.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        inputContainerView2.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        inputContainerView2.addSubview(popImage)
        
        
        //need x, y , wifth, height, constraints
        popImage.centerXAnchor.constraint(equalTo: inputContainerView2.centerXAnchor).isActive = true
        
        popImage.centerYAnchor.constraint(equalTo: inputContainerView2.centerYAnchor).isActive = true
        
     //     popImage.bottomAnchor.constraint(equalTo: inputContainerView2.topAnchor, constant: 2).isActive = true
        
        popImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        popImage.heightAnchor.constraint(equalToConstant: 60).isActive = true

    }
    
 
    
    func setupdddd(){
        //need x, y , wifth, height, constraints
        ddd.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ddd.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        ddd.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        ddd.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
       // ddd = inputContainerView.heightAnchor.constraint(equalToConstant: view!.heightAnchor)
      //  dddHeightAnchor?.isActive = true
    }
    
    func setupthebutton(){
     //   need x, y , wifth, height, constraints
        theButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        theButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        theButton.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        theButton.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
     //    ddd = inputContainerView.heightAnchor.constraint(equalToConstant: view!.heightAnchor)
          dddHeightAnchor?.isActive = true
    }
    
    func setthetext(){
        matchLabel.text = myUserName3! + ", your message has been sent!."
    }
    
}
