//
//  LoginVC.swift
//  Messanger
//
//  Created by Dave on 2/2/21.
//

import UIKit

class LoginVC: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageAssets.chatIcon.image
        return imageView
    }()
    
    private let emaiField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 15
        field.layer.borderWidth = 2
        field.layer.borderColor = UIColor.red.cgColor
        field.placeholder = "Email Address..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 15
        field.layer.borderWidth = 2
        field.layer.borderColor = UIColor.red.cgColor
        field.placeholder = "Email Address..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        return field
    }()
    
    private let loginBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .link
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        constraints()
         
    }
    
    //MARK: - Set up views
    
    private func setUpViews() {
        view.backgroundColor = .white
        title = "Log In"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))
        loginBtn.addTarget(self, action: #selector(logInBtnTapped), for: .touchUpInside)
        emaiField.delegate  = self
        passwordField.delegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emaiField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginBtn)
    }
    
    //MARK: - Constraints
    private func constraints() {
        scrollView.frame = view.bounds
        
        let size = scrollView.width/3
        imageView.frame = CGRect(x:(scrollView.width - size)/2, y: 20, width: size, height: size)
        emaiField.frame = CGRect(x:30, y: imageView.bottom + 10, width: scrollView.width - 60, height: 50)
        passwordField.frame = CGRect(x:30, y: emaiField.bottom + 10, width: scrollView.width - 60, height: 50)
        loginBtn.frame = CGRect(x:30, y: passwordField.bottom + 10, width: scrollView.width - 60, height: 50)
    }
    
    @objc private func logInBtnTapped() {
        
        emaiField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emaiField.text, let password = passwordField.text, !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            alertUserLogInError()
            return
            
        }
        
    }
    
    func alertUserLogInError() {
        let alert = UIAlertController(title: "Error", message: "Please enter all information correctly", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @objc private func didTapRegister() {
        let vc  = RegisterVC()
        vc.title = "Register"
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emaiField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            logInBtnTapped()
        }
        
        return true
    }
}
