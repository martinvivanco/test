//
//  ProfileViewController.swift
//  test
//
//  Created by everis on 1/18/21.
//  Copyright © 2021 martin. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ProfileViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    // MARK: - Properties
    var ref: DatabaseReference!
    // MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    func setup() {
        ref = Database.database().reference()
        navigationItem.title = "Crear Perfil"
        nameTextField.delegate = self
        ageTextField.delegate = self
        dateTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    func validateDate() {
        if let name = nameTextField.text, let age = ageTextField.text, let date = dateTextField.text, !name.isEmpty, !age.isEmpty, !date.isEmpty {
            let user = Auth.auth().currentUser
            self.ref.child("user").child(user!.uid).setValue(["username":name, "age": age, "date":date])
            let alertController = UIAlertController(title: "Exito", message: "Registro exitoso", preferredStyle: .alert)
            let action = UIAlertAction(title: "Exito", style: .default) { (success) in
                self.navigationController?.popViewController(animated: true)
            }
            alertController.addAction(action)
            self.present(alertController,animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Error", message: "Faltan completar datos", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
            self.present(alertController,animated: true, completion: nil)
        }
    }
    @IBAction func registerAction(_ sender: Any) {
        validateDate()
    }
}
extension ProfileViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == dateTextField {
        if dateTextField.text?.count == 2 || dateTextField.text?.count == 5 {
                if !(string == "") {
                    dateTextField.text = dateTextField.text! + "/"
                }
            }
            return !(textField.text!.count > 9 && (string.count ) > range.length)
        } else {
            return true
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension UIViewController {

    @objc func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
