//
//  HomeViewController.swift
//  test
//
//  Created by everis on 1/18/21.
//  Copyright © 2021 martin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - IBOutlets
    // MARK: - Properties
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Menu"
    }
    @IBAction func createProfileAction(_ sender: Any) {
        self.performSegue(withIdentifier: "segueToPorfile", sender: nil)
    }
    @IBAction func peopleAction(_ sender: Any) {
    }
    
}
