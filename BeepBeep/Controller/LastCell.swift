//
//  LastCell.swift
//  BeepBeep
//
//  Created by Aviv Dimri on 21/01/2019.
//  Copyright © 2019 Aviv Dimri. All rights reserved.
//

import UIKit

class LastCell: UICollectionViewCell {
    
    let logoImageView: UIImageView = {
        let image = UIImage(named: "stop-sign")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "You have finished the Tutorial.  Press the Finish button to go back to the main page."
        tv.isEditable = false
         tv.font = UIFont.boldSystemFont(ofSize: 22)
        //tv.font = tv.font?.withSize(30)
         tv.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
       // tv.contentInset = UIEdgeInsets(top: -4, left: -8, bottom: 0, right: 0)
        tv.contentMode = .scaleToFill
        return tv
    }()
    
    lazy var FinishButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.white
        //button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("Finish", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        // button.layer.borderColor = UIColor.black as! CGColor
        
        button.addTarget(self, action: #selector(handleFinish), for: .touchUpInside )
        
        return button
    }()
    
    var checkViewController: CheckViewController?
    
    @objc func handleFinish(){
      //  print("byebye")
        checkViewController?.FinishedButton()
    }
    
   
    
    override init(frame: CGRect) {
    super.init(frame: frame)
        
        addSubview(logoImageView)
        addSubview(textView)
        addSubview(FinishButton)
        
        _ = logoImageView.anchor(centerYAnchor, left: nil, bottom: nil, right: nil, topConstant: -200, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 160, heightConstant: 160)
        logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        _ = textView.anchor(logoImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 140)
        
        textView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        
        _ = FinishButton.anchor(textView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 60, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
        FinishButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        
}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
}
