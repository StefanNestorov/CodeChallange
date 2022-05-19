//
//  LoginScreen.swift
//  Code_Challenge
//
//  Created by Stefan Nestorov on 18.05.22.
//  Copyright © 2022 JOOR. All rights reserved.
//

import UIKit
import Combine

class LoginScreen: BaseVC {
    
    // MARK: - Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private let viewModel = LoginVM()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        bindViewModel()
        //Cleanup the navigation stack
        navigationController?.viewControllers.removeAll { $0 is FeedScreen }
        
    }
    
    // MARK: - Instance methods
    
    private func bindViewModel() {
        
        viewModel.$isLoggedIn
            .sink { [weak self] isLoggedIn in
                if isLoggedIn {
                    self?.navigateToFeedScreen()
                }
            }
            .store(in: &cancellables)
        
        //Adding two way binding between the textfields and the viewmodel (similar to swiftUI.. maybe some library can be used, but this should be fine too)
        viewModel.$name
            .filter { [weak self] newValue in
                newValue != self?.nameTextField.text
            }
            .sink { [weak self] newValue in
                self?.nameTextField.text = newValue
            }
            .store(in: &cancellables)
        
        nameTextField.textPublisher()
            .sink { [weak self] newValue in
                self?.viewModel.name = newValue
            }
            .store(in: &cancellables)
        
        viewModel.$password
            .filter { [weak self] newValue in
                newValue != self?.passwordTextField.text
            }
            .sink { [weak self] newValue in
                self?.passwordTextField.text = newValue
            }
            .store(in: &cancellables)

        passwordTextField.textPublisher()
            .sink { [weak self] newValue in
                self?.viewModel.password = newValue
            }
            .store(in: &cancellables)
        
    }
    
    private func navigateToFeedScreen() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let feedScreen = storyboard.instantiateViewController(withIdentifier: "FeedScreenID") as? FeedScreen {
            view.endEditing(true)
            navigationController?.pushViewController(feedScreen, animated: true)
        }
        
    }
    
    @IBAction func onLoginPressed(_ sender: Any) {
        viewModel.onLoginPressed()
    }
    
}

// MARK: - UITextFieldDelegate
extension LoginScreen: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
