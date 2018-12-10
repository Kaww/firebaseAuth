//
//  HomeController.swift
//  firebaseAuthentification
//
//  Created by kaww on 05/12/2018.
//  Copyright © 2018 Kaww. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var testButton: UIButton!
    @IBOutlet weak var test2Button: UIButton!
    @IBOutlet weak var test3Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        setupLabels()
        if Auth.auth().currentUser != nil {
            let db = Database.database().reference()
            let userID = Auth.auth().currentUser?.uid
            db.child("users").child(userID!).observeSingleEvent(of: .value) { (snapshot) in
                let value = snapshot.value as? NSDictionary
                let username = value?["username"] as? String ?? "no username"
                self.nameLabel.text = username
            }
        } else {
            fatalError("Aucun utilisateur connecté")
        }
    }
    
    // MARK: Private methods
    private func setupButtons() {
        logoutButton.layer.cornerRadius = logoutButton.frame.height / 2
        logoutButton.layer.shadowColor = UIColor.darkGray.cgColor
        logoutButton.layer.shadowRadius = 5
        logoutButton.layer.shadowOpacity = 0.6
        logoutButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        test3Button.layer.cornerRadius = test2Button.frame.height / 2
        test3Button.layer.shadowColor = UIColor.darkGray.cgColor
        test3Button.layer.shadowRadius = 5
        test3Button.layer.shadowOpacity = 0.6
        test3Button.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        test2Button.layer.cornerRadius = test2Button.frame.height / 2
        test2Button.layer.shadowColor = UIColor.darkGray.cgColor
        test2Button.layer.shadowRadius = 5
        test2Button.layer.shadowOpacity = 0.6
        test2Button.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        testButton.layer.cornerRadius = testButton.frame.height / 2
        testButton.layer.shadowColor = UIColor.darkGray.cgColor
        testButton.layer.shadowRadius = 5
        testButton.layer.shadowOpacity = 0.6
        testButton.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    private func setupLabels() {
        nameLabel.text = ""
    }
    
    // MARK: Actions
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        sender.shake()
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch {
            print("Impossible de deconnecter l'utilisateur")
        }
    }
    
    @IBAction func testButtonPressed(_ sender: UIButton) {
        sender.pulsate()
    }
    
    @IBAction func test2ButtonPressed(_ sender: UIButton) {
        sender.flash()
    }
    
    @IBAction func test3ButtonPressed(_ sender: UIButton) {
        sender.shake()
    }
}
