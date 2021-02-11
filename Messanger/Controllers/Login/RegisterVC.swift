//
//  RegisterVC.swift
//  Messanger
//
//  Created by Dave on 2/2/21.
//

import UIKit

class RegisterVC: UIViewController, UINavigationControllerDelegate {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageAssets.chatIcon.image
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let firstNameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 15
        field.layer.borderWidth = 2
        field.layer.borderColor = UIColor.red.cgColor
        field.placeholder = "First Name..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private let LastNameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 15
        field.layer.borderWidth = 2
        field.layer.borderColor = UIColor.red.cgColor
        field.placeholder = "Last Name..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
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
        field.placeholder = "Password..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        return field
    }()
    
    private let registerBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .green
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
        title = "Register"
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(LastNameField)
        scrollView.addSubview(emaiField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerBtn)
        
        
        self.imageView.isUserInteractionEnabled = true
        self.scrollView.isUserInteractionEnabled = true
        registerBtn.addTarget(self, action: #selector(registerBtnTapped), for: .touchUpInside)
        emaiField.delegate  = self
        passwordField.delegate = self
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeImage))
        imageView.addGestureRecognizer(gesture)
        
    }
    
    //MARK: - Constraints
    private func constraints() {
        scrollView.frame = view.bounds
        
        let size = scrollView.width/3
        imageView.frame = CGRect(x:(scrollView.width - size)/2, y: 20, width: size, height: size)
        imageView.layer.cornerRadius = imageView.width/2.0
        firstNameField.frame = CGRect(x:30, y: imageView.bottom + 10, width: scrollView.width - 60, height: 50)
        LastNameField.frame = CGRect(x:30, y: firstNameField.bottom + 10, width: scrollView.width - 60, height: 50)
        emaiField.frame = CGRect(x:30, y: LastNameField.bottom + 10, width: scrollView.width - 60, height: 50)
        passwordField.frame = CGRect(x:30, y: emaiField.bottom + 10, width: scrollView.width - 60, height: 50)
        registerBtn.frame = CGRect(x:30, y: passwordField.bottom + 10, width: scrollView.width - 60, height: 50)
    }
    
    @objc private func registerBtnTapped() {
        
        emaiField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let firstName = firstNameField.text, let lastName = LastNameField.text ,let email = emaiField.text, let password = passwordField.text, !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, !password.isEmpty, password.count >= 6 else {
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

    @objc private func didTapChangeImage() {
        pickImageAlert()
    }
}

extension RegisterVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emaiField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            registerBtnTapped()
        }
        
        return true
    }
}

extension RegisterVC: UIImagePickerControllerDelegate {
    func pickImageAlert() {
        let actionSheet = UIAlertController(title: "Profile picture", message: "How would you like to choose profile picture", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [weak self] _ in
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {[weak self] _ in
            self?.presentPhotoLibrary()
        }))
        present(actionSheet, animated: true, completion: nil)
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.sourceType = .camera
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }
    
    func presentPhotoLibrary() {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image  = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        self.imageView.image = image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
