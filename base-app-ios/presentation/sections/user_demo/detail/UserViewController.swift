//
//  UserViewController.swift
//  base-app-ios
//
//  Created by Roberto Frontado on 2/18/16.
//  Copyright © 2016 Roberto Frontado. All rights reserved.
//

import UIKit
import RxSwift

class UserViewController: BaseViewController<UserPresenter> {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // If it is the first viewController of the navigationController, then add the MenuButton to the navigationBar
        if self.navigationController?.viewControllers.first == self {
            let menuButton = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.Plain, target: self, action: "menuButtonPressed:")
            navigationItem.leftBarButtonItem = menuButton
        }
        
        presenter.getCurrentUser()
            .safelyReport(self)
            .subscribeNext { user in self.showUser(user) }
    }
    
    // MARK: - Private methods
    private func showUser(user: User) {
        userNameLabel.text = user.login
        if let imageURL = NSURL(string: user.getAvatarUrl()) {
            userImageView.sd_setImageWithURL(imageURL)
        }
    }
    
    func menuButtonPressed(sender: UIButton) {
        slideMenuController()?.openLeft()
    }

    // MARK: - Actions
    @IBAction func findUserButtonPressed(sender: UIButton) {
        wireframe.searchUserScreen()
    }
}
