//
//  MessageBeenSent.swift
//  BeepBeep
//
//  Created by Aviv Dimri on 27/02/2019.
//  Copyright © 2019 Aviv Dimri. All rights reserved.
//

import UIKit

class MessageBeenSent: UIViewController {
    
    var titletxt: String?
    var bodytxt: String?
    
    let titleLabel = UILabel()
    let bodyLabel = UILabel()
    

    fileprivate func setupLabels() {
   //     titleLabel.backgroundColor = .red
    //    bodyLabel.backgroundColor = .green
        titleLabel.numberOfLines = 0
        titleLabel.text = "Welcome to Company XYZ"
     //   titleLabel.font = UIFont(name: "Future", size: 34)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        bodyLabel.numberOfLines = 0
        bodyLabel.text =  "Go check your incoming messages to see the new message that you have been recived."
    }
    
    fileprivate func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, bodyLabel])
        
        stackView.axis = .vertical
        stackView.spacing = 8
        
        view.addSubview(stackView)
        
        
        
        //enable autolayout
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor,constant: -100).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(true, animated: true)

        
        setupLabels()
        
    //    view.backgroundColor = .yellow
        view.backgroundColor = .white
        
        setupStackView()
        
        settexts()
        
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapAnimations)))
        
        
    }
    @objc fileprivate func handleTapAnimations(){
        print("Animating")
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            self.titleLabel.transform = CGAffineTransform(translationX: -30, y: 0)
        }) { (_) in
        
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.titleLabel.alpha = 0
                self.titleLabel.transform = self.titleLabel.transform.translatedBy(x: 0, y: -200)
                
            })
        }
        
        UIView.animate(withDuration: 0.5, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            
            self.bodyLabel.transform = CGAffineTransform(translationX: -30, y: 0)
        }) { (_) in
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.bodyLabel.alpha = 0
                self.bodyLabel.transform = self.bodyLabel.transform.translatedBy(x: 0, y: -200)
                
            })
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
        self.dismiss(animated: true, completion: nil)
        })
    }
    
    func settexts(){
        titleLabel.text = titletxt! + ", You recvived a new message"
    }

}
