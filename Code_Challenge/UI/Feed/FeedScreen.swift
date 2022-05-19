//
//  FeedScreen.swift
//  Code_Challenge
//
//  Created by Stefan Nestorov on 18.05.22.
//  Copyright © 2022 JOOR. All rights reserved.
//

import UIKit

class FeedScreen: BaseVC {

    // MARK: - Properties
    @IBOutlet weak var feedTableView: UITableView!
    private let viewModel = FeedVM()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        bindViewModel()
        //Cleanup the navigation stack
        navigationController?.viewControllers.removeAll { $0 is LoginScreen }
        
    }
    
    // MARK: - Instance methods
    
    private func bindViewModel() {
        
        viewModel.$isLoggedIn
            .sink { [weak self] isLoggedIn in
                if !isLoggedIn {
                    self?.navigateToLoginScreen()
                }
            }
            .store(in: &cancellables)
        
        viewModel.$feed
            .sink { [weak self] newFeed in
                self?.feedTableView.reloadData()
            }
            .store(in: &cancellables)
        
    }
    
    private func navigateToLoginScreen() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let loginScreen = storyboard.instantiateViewController(withIdentifier: "LoginScreenID") as? LoginScreen {
            navigationController?.pushViewController(loginScreen, animated: true)
        }
        
    }
    
    @IBAction func onLogoutPressed(_ sender: Any) {
        viewModel.onLogoutPressed()
    }
    
}

// MARK: - UITableViewDataSource/UITableViewDelegate Methods
extension FeedScreen: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String.init(describing: FeedCell.self), for: indexPath) as! FeedCell
        cell.tweet = viewModel.feed[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.feed.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
