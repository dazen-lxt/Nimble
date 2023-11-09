//
//  ForgotPasswordViewController.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 7/11/23.
//

import UIKit

class ForgotPasswordViewController: BaseViewController {
    
    var interactor: ForgotPasswordBusinessLogic?
    var router: ForgotPasswordWireframeLogic?

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.18).cgColor
        textField.layer.cornerRadius = 12
        textField.font = Fonts.textField
        textField.textColor = UIColor.white
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: attributes)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.size.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.returnKeyType = .done
        return textField
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.backgroundColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 10
        button.setTitle("Reset", for: .normal)
        button.titleLabel?.font = Fonts.button
        button.setTitleColor(UIColor.black, for: .normal)
        button.isEnabled = false
        return button
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "NumbleIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = UIColor.white
        return button
    }()
    
    private let resetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enter your email to receive instructions for resetting your password."
        label.font = Fonts.paragraph
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let horizontalMargin: CGFloat = 24.0
    private let heightInputs: CGFloat = 56.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setUpViews()
        setUpTargets()
    }
    
    private func setUpViews() {
        view.addSubview(emailTextField)
        view.addSubview(logoImageView)
        view.addSubview(resetLabel)
        view.addSubview(resetButton)
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin),
            emailTextField.heightAnchor.constraint(equalToConstant: heightInputs),
            
            resetButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20.0),
            resetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin),
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin),
            resetButton.heightAnchor.constraint(equalToConstant: heightInputs),
            
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.2),
            
            resetLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            resetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin),
            resetLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin),
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin),
            backButton.heightAnchor.constraint(equalToConstant: 50.0),
            backButton.widthAnchor.constraint(equalToConstant: 40.0)
            
        ])
    }
    
    private func setUpTargets() {
        emailTextField.addTarget(self, action: #selector(validateTextField), for: .editingChanged)
        resetButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func setupBackground() {
        let container = UIView(frame: UIScreen.main.bounds)
        let backgroundImage = UIImageView(frame: container.bounds)
        backgroundImage.image = UIImage(named: "Background")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        container.addSubview(backgroundImage)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 0.5, ty: 0))
        gradientLayer.frame = container.bounds
        gradientLayer.frame.size.height -= view.safeAreaInsets.bottom
        gradientLayer.position = container.center

        container.layer.addSublayer(gradientLayer)

        
        view.addSubview(container)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
    
    private func isValidEmail(_ email: String?) -> Bool {
        if let email = email {
            let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: email)
        }
        return false
    }
    
    @objc private func validateTextField() {
        if isValidEmail(emailTextField.text) {
            resetButton.isEnabled = true
            resetButton.layer.backgroundColor = UIColor.white.cgColor
        } else {
            resetButton.isEnabled = false
            resetButton.layer.backgroundColor = UIColor.gray.cgColor
        }
    }

    @objc private func loginButtonTapped() {
        showLoading()
        interactor?.sendForgotPassword(email: emailTextField.text ?? "")
    }

    @objc private func backButtonTapped() {
        router?.goBack()
    }
}

extension ForgotPasswordViewController: ForgotPasswordDisplayLogic {
    
    func displayForgotPasswordSuccess(message: String) {
        hideLoading()
        showSuccessMessage(message)
    }
    
    func displayError(error: String) {
        hideLoading()
        showErrorMessage(error)
    }
}
