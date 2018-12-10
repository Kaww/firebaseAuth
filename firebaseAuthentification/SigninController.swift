//
//  ViewController.swift
//  firebaseAuthentification
//
//  Created by kaww on 03/12/2018.
//  Copyright © 2018 Kaww. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SigninController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!

    // MARK: Properties
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        setupTextFieldManager()
    }
    
    // MARK: Private methods
    private func setupButtons() {
        signupButton.layer.cornerRadius = 20
        
        loginButton.layer.cornerRadius = 20
        loginButton.layer.borderWidth = 3
        loginButton.layer.borderColor = UIColor.white.cgColor
    }
    
    private func setupTextFieldManager() {
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    // MARK: Actions
    @objc private func hideKeyboard() {
        usernameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @IBAction func signupButtonPressed(_ sender: UIButton) {
        if usernameTextField.text != "" && emailTextField.text != "" && passwordTextField.text != "" {
            print("Inscription de \(usernameTextField.text ?? "no name") en cours...")
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authResult, error) in
                if error != nil {
                    print(error.debugDescription)
                } else {
                    print("Inscription de \(self.usernameTextField.text ?? "no name") ✅")
                    
                    let db = Database.database().reference()
                    let userID = Auth.auth().currentUser?.uid
                    db.child("users").child(userID!).setValue(["username": self.usernameTextField.text!])
                    
                    self.performSegue(withIdentifier: "goToHome", sender: self)
                    self.usernameTextField.text = ""
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                }
            }
        } else {
            sender.shake()
            print("Erreur: les champs ne sont pas complets.")
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        print("redirection vers l'écran de login.")
    }
    
}

extension SigninController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
