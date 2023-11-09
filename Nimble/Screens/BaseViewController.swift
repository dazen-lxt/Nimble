//
//  BaseViewController.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 8/11/23.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
            loadingNotification.mode = MBProgressHUDMode.indeterminate
            loadingNotification.label.text = "Loading..."
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func showSuccessMessage(_ message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let successNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
            successNotification.mode = MBProgressHUDMode.customView
            successNotification.customView = UIImageView(image: UIImage(named: "checkmark-icon"))
            successNotification.label.text = message
            successNotification.label.numberOfLines = 0
            successNotification.hide(animated: true, afterDelay: 4.0)
        }
    }
    
    func showErrorMessage(_ message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let errorNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
            errorNotification.mode = MBProgressHUDMode.customView
            errorNotification.customView = UIImageView(image: UIImage(named: "error-icon"))
            errorNotification.label.text = "Error"
            errorNotification.detailsLabel.numberOfLines = 0
            errorNotification.detailsLabel.text = message
            errorNotification.hide(animated: true, afterDelay: 3.0)
        }
    }
}
