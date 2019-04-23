//
//  CheckViewController.swift
//  BeepBeep
//
//  Created by Aviv Dimri on 10/01/2019.
//  Copyright © 2019 Aviv Dimri. All rights reserved.
//

import UIKit

class CheckViewController: UIViewController, UICollectionViewDataSource,
UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let isFirstLaunch = UserDefaults.isFirstLaunch()

    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    
    let cellId = "cellId"
    let loginCellId = "loginCellId"
    
    let pages: [Page] = {
        let firstPage = Page(title: "The main page", message: "If you saw someone car's and you want to inform him about something crucial.",imageName: "nisayon3")
        
        let secondPage = Page(title: "Enter the car number", message: "Enter the car number that you want to send message to and inform about.", imageName: "pagenisayon")
        
        let thirdPage = Page(title: "Choose message", message: "Choose the message you want to send. \n if you want to send another message press on Other and write your own message", imageName: "kalak")
        
        let fourthPage = Page(title: "Check messages", message: "To check if there are any messages that you have recived from other people press the Bell icon", imageName: "beforelast")
        
        let fifthPage = Page(title: "View all messages", message: "View all the messages you recived,(with delete option). \n new messages will have exclamation mark icon.", imageName: "kalak2")
        
        let sixthPage = Page(title: "Replay the tutorial", message: "You always can see the tutorial again by clicking settings and then the tutorial button.", imageName: "last")
        
        return [firstPage, secondPage,thirdPage,fourthPage,fifthPage,sixthPage]
    }()

    lazy var pageControl: UIPageControl = {
       let pc = UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        pc.numberOfPages = self.pages.count + 1
        pc.currentPageIndicatorTintColor = UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1)
        return pc
    }()
    
    let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(skipPage), for: .touchUpInside)
        return button
    }()
    @objc func skipPage(){
        
        if isFirstLaunch{
            let logincontroller = LoginController()
            let navController = UINavigationController(rootViewController: logincontroller)
            present(navController,animated: true, completion: nil)
            
        }else{
            let maincontroller = MainController()
            let navController = UINavigationController(rootViewController: maincontroller)
            present(navController,animated: true, completion: nil)
        }
        
        
        
    }
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        return button
    }()
    
    @objc func nextPage(){
        
        if pageControl.currentPage == pages.count {
            return
        }
        if pageControl.currentPage == pages.count - 1{
            moveControlConstraintsOffScreen()
        }
        let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage += 1
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    
    var pageControlBottomAnchor: NSLayoutConstraint?
    var skipButtonTopAnchor: NSLayoutConstraint?
    var nextButtonTopAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        
        pageControlBottomAnchor = pageControl.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)[1]
        
        
        skipButtonTopAnchor = skipButton.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50).first
        
        nextButtonTopAnchor = nextButton.anchor(view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50).first
        
       // collectionView.frame = view.frame
        
        //use autolayout instead
        
        collectionView.anchorToTop(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        registerCells()
       // collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellId)
        
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageNumber
        
        if pageNumber == pages.count {
       //     print("animate controls off screen")
            moveControlConstraintsOffScreen()
            
           
        } else {
            pageControlBottomAnchor?.constant = 0
            skipButtonTopAnchor?.constant = 16
            nextButtonTopAnchor?.constant = 16
        }
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        //print(pageNumber)
    }
    
    fileprivate func moveControlConstraintsOffScreen(){
        pageControlBottomAnchor?.constant = 400
        skipButtonTopAnchor?.constant = -40
        nextButtonTopAnchor?.constant = -40
        
    }
    fileprivate func registerCells() {
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(LastCell.self, forCellWithReuseIdentifier: loginCellId)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
    
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 4
//    }
//
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == pages.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath) as! LastCell
            loginCell.checkViewController = self
            return loginCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell
        
        let page = pages[indexPath.item]
        cell.page = page
        
      //  cell.backgroundColor  = .white
        return cell
    }
    
    func FinishedButton(){
        skipPage()
       // print("bigcheck1")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
       return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
    }
    



}



