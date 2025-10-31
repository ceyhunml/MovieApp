//
//  SignUpViewController.swift
//  MovieApp
//
//  Created by Ceyhun Məmmədli on 28.10.25.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage.mainLogo
        return iv
    }()
    
    private lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.layer.cornerRadius = 16
        tf.clipsToBounds = true
        tf.backgroundColor = .secondarySystemBackground
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Email"
        return tf
    }()
    
    private lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.layer.cornerRadius = 16
        tf.clipsToBounds = true
        tf.backgroundColor = .secondarySystemBackground
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Password"
        return tf
    }()
    
    private lazy var signUpButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Sign Up"
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.cornerStyle = .large
        config.buttonSize = .large
        let b = UIButton(configuration: config)
        b.layer.cornerRadius = 16
        b.layer.shadowColor = UIColor.tintColor.cgColor
        b.layer.shadowOpacity = 8
        b.layer.shadowOffset = CGSize(width: 0, height: 2)
        b.layer.shadowRadius = 8
        b.clipsToBounds = true
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    let viewModel = SignUpViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        hideKeyboardWhenTappedAround()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 100),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 60),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60),
            
            signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func signUpTapped() {
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            viewModel.signUp(email: email, password: password)
        }
    }
}
