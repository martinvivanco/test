//
//  ViewController.swift
//  test
//
//  Created by everis on 1/17/21.
//  Copyright © 2021 martin. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth

class LoginViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var loginButton: UIButton!
    // MARK: - Properties
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func showHome(result: AuthDataResult?, error: Error?) {
        if let result = result, error == nil {
            self.performSegue(withIdentifier: "segueToHome", sender: nil)
        } else {
            let alertController = UIAlertController(title: "Error", message: "Se ha producido un error de autenticación", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
            self.present(alertController,animated: true, completion: nil)
        }
    }
    
    @IBAction func facebookLoginAction(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn(permissions: [.email], viewController: self) { (result) in
            switch result {
            case .success(granted: let granted, declined: let declined, token: let token):
                let credential = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
                Auth.auth().signIn(with: credential) { (result, error) in
                    self.showHome(result: result, error: error)
                }
            case .cancelled:
                break
            case .failed(_):
                break
            }
            
        }
    }
    
}

