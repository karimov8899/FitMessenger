//
//  ViewController.swift
//  Messanger
//
//  Created by Dave on 2/2/21.
//

import UIKit

class ConversationsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setUpViews()
    }
 
    //MARK: - Adding subviews
    private func setUpViews() {
         
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
        
        if !isLoggedIn {
            let vc = LoginVC()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }
    
}

