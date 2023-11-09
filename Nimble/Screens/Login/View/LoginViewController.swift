//
//  LoginViewController.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 7/11/23.
//

import UIKit

class LoginViewController: BaseViewController {
    
    var interactor: LoginBusinessLogic?
    var router: LoginWireframeLogic?

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
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.18).cgColor
        textField.layer.cornerRadius = 12
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.font = Fonts.textField
        textField.textColor = UIColor.white
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: attributes)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.size.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        let paddingRightView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: textField.frame.size.height))
        textField.rightView = paddingRightView
        textField.rightViewMode = .always
        textField.returnKeyType = .done
        return textField
    }()
    
    private let forgotButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Forgot?", for: .normal)
        button.titleLabel?.font = Fonts.paragraph
        button.setTitleColor(UIColor.lightGray, for: .normal)
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.backgroundColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 10
        button.setTitle("Log In", for: .normal)
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
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(logoImageView)
        view.addSubview(forgotButton)
        
        NSLayoutConstraint.activate([
            
            passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin),
            passwordTextField.heightAnchor.constraint(equalToConstant: heightInputs),
            
            emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin),
            emailTextField.heightAnchor.constraint(equalToConstant: heightInputs),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20.0),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalMargin),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalMargin),
            loginButton.heightAnchor.constraint(equalToConstant: heightInputs),
            
            logoImageView.bottomAnchor.constraint(equalTo: emailTextField.topAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor),
            
            forgotButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            forgotButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -horizontalMargin),
            
        ])
    }
    
    private func setUpTargets() {
        emailTextField.addTarget(self, action: #selector(validateTextField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(validateTextField), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        forgotButton.addTarget(self, action: #selector(forgotButtonTapped), for: .touchUpInside)
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

    private func isPasswordValid(_ password: String?) -> Bool {
        if let password = password, password.count >= 6 {
            return true
        }
        return false
    }
    
    @objc private func validateTextField() {
        if isValidEmail(emailTextField.text) && isPasswordValid(passwordTextField.text) {
            loginButton.isEnabled = true
            loginButton.layer.backgroundColor = UIColor.white.cgColor
        } else {
            loginButton.isEnabled = false
            loginButton.layer.backgroundColor = UIColor.gray.cgColor
        }
    }

    @objc private func loginButtonTapped() {
        showLoading()
        interactor?.loginUser(username: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    @objc private func forgotButtonTapped() {
        router?.presentForgotPassword()
    }

}

extension LoginViewController: LoginDisplayLogic {
    
    func displayLoginSuccess() {
        hideLoading()
        router?.goToList()
    }
    
    func displayError(error: String) {
        hideLoading()
        showErrorMessage(error)
    }
}
