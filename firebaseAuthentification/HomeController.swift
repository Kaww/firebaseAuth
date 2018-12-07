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
        logoutButton.layer.cornerRadius = 20
    }
    
    private func setupLabels() {
        nameLabel.text = ""
    }
    
    // MARK: Actions
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
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
}
