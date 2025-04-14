//
//  LoginSheetViewController.swift
//  SampleApp3
//
//  Created by Shivansh Sharma on 13/04/25.
//

protocol LoginSuccess: AnyObject {
    func loginSuccess()
}

import UIKit

class LoginOptionsViewController: UIViewController {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    private let closeButton = UIButton()
    private let titleLabel = UILabel()
    private let googleButton = UIButton(type: .system)
    private let appleButton = UIButton(type: .system)
    private let orLabel = UILabel()
    private let leftDivider = UIView()
    private let rightDivider = UIView()
    private let emailField = UITextField()
    private let continueButton = UIButton(type: .system)
    
    private var continueButtonBottomConstraint: NSLayoutConstraint!
    
    weak var delegate: LoginSuccess?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
        setupLayout()
        setupKeyboardObservers()
        setupLoader()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - UI Setup
    
    private func setupLoader() {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupUI() {
        setupTitleLabel()
        setupCloseButton()
        setupGoogleButton()
        setupAppleButton()
        setupOrSection()
        setupEmailField()
        setupContinueButton()
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "Continue living"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        titleLabel.numberOfLines = 3
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
    }
    
    private func setupCloseButton() {
        closeButton.setImage(UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate), for: .normal)
        closeButton.tintColor = .white
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        view.addSubview(closeButton)
    }
    
    private func setupGoogleButton() {
        configureButtonWithIcon(button: googleButton, title: "Log in with Google", iconName: "google-icon")
        googleButton.addTarget(self, action: #selector(handleGoogleLogin), for: .touchUpInside)
        view.addSubview(googleButton)
    }
    
    private func setupAppleButton() {
        configureButtonWithIcon(button: appleButton, title: "Log in with Apple", iconName: "apple-icon")
        appleButton.addTarget(self, action: #selector(handleAppleLogin), for: .touchUpInside)
        view.addSubview(appleButton)
    }
    
    private func setupOrSection() {
        orLabel.text = "or"
        orLabel.textColor = .white
        orLabel.textAlignment = .center
        view.addSubview(orLabel)
        
        leftDivider.backgroundColor = .gray
        rightDivider.backgroundColor = .gray
        view.addSubview(leftDivider)
        view.addSubview(rightDivider)
    }
    
    private func setupEmailField() {
        emailField.placeholder = "Enter email"
        emailField.attributedPlaceholder = NSAttributedString(
            string: emailField.placeholder ?? "",
            attributes: [
                .foregroundColor: UIColor.gray,
                .font: UIFont.systemFont(ofSize: 16)
            ]
        )
        emailField.borderStyle = .roundedRect
        emailField.keyboardType = .emailAddress
        emailField.textColor = .white
        emailField.backgroundColor = .darkGray.withAlphaComponent(0.3)
        emailField.delegate = self
        view.addSubview(emailField)
    }
    
    private func setupContinueButton() {
        continueButton.setTitle("Get OTP", for: .normal)
        continueButton.backgroundColor = .white
        continueButton.setTitleColor(.black, for: .normal)
        continueButton.layer.cornerRadius = 8
        continueButton.isHidden = true // Initially hidden
        continueButton.addTarget(self, action: #selector(handleContinueTap), for: .touchUpInside)
        view.addSubview(continueButton)
    }
    
    private func configureButtonWithIcon(button: UIButton, title: String, iconName: String) {
        let iconImageView = UIImageView(image: UIImage(named: iconName))
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        
        let stack = UIStackView(arrangedSubviews: [iconImageView, label])
        stack.axis = .horizontal
        stack.spacing = 6
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isUserInteractionEnabled = false
        
        button.backgroundColor = .darkGray.withAlphaComponent(0.3)
        button.layer.cornerRadius = 8
        button.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        
        iconImageView.layer.cornerRadius = 12.5
        iconImageView.layer.masksToBounds = true
    }
    
    // MARK: - Layout Setup
    
    private func setupLayout() {
        [titleLabel, googleButton, appleButton, orLabel, emailField, leftDivider, rightDivider, continueButton, closeButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            closeButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
            closeButton.heightAnchor.constraint(equalToConstant: 32),
            closeButton.widthAnchor.constraint(equalToConstant: 32),
            closeButton.trailingAnchor.constraint(equalTo: googleButton.trailingAnchor),
            
            googleButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            googleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            googleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            googleButton.heightAnchor.constraint(equalToConstant: 48),
            
            appleButton.topAnchor.constraint(equalTo: googleButton.bottomAnchor, constant: 16),
            appleButton.leadingAnchor.constraint(equalTo: googleButton.leadingAnchor),
            appleButton.trailingAnchor.constraint(equalTo: googleButton.trailingAnchor),
            appleButton.heightAnchor.constraint(equalToConstant: 48),
            
            orLabel.topAnchor.constraint(equalTo: appleButton.bottomAnchor, constant: 24),
            orLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            leftDivider.centerYAnchor.constraint(equalTo: orLabel.centerYAnchor),
            leftDivider.leadingAnchor.constraint(equalTo: googleButton.leadingAnchor),
            leftDivider.trailingAnchor.constraint(equalTo: orLabel.leadingAnchor, constant: -12),
            leftDivider.heightAnchor.constraint(equalToConstant: 1),
            
            rightDivider.centerYAnchor.constraint(equalTo: orLabel.centerYAnchor),
            rightDivider.leadingAnchor.constraint(equalTo: orLabel.trailingAnchor, constant: 12),
            rightDivider.trailingAnchor.constraint(equalTo: googleButton.trailingAnchor),
            rightDivider.heightAnchor.constraint(equalToConstant: 1),
            
            emailField.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 20),
            emailField.leadingAnchor.constraint(equalTo: googleButton.leadingAnchor),
            emailField.trailingAnchor.constraint(equalTo: googleButton.trailingAnchor),
            emailField.heightAnchor.constraint(equalToConstant: 44),
            
            continueButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            continueButton.leadingAnchor.constraint(equalTo: googleButton.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: googleButton.trailingAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        continueButtonBottomConstraint = continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        continueButtonBottomConstraint.isActive = true
    }
    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Actions
    
    @objc func handleGoogleLogin() {
        // Show loader and disable interaction
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {[weak self] in
            // Stop loader
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            self.view.isUserInteractionEnabled = true
            LaunchManager.shared.markIntroSeen()
            self.dismiss(animated: true) {
                self.delegate?.loginSuccess()
            }
        }
    }
    
    @objc func closeTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func handleAppleLogin() {
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {[weak self] in
            let alert = UIAlertController(title: "Apple login failed", message: "Try again or use Google/Email.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true, completion: { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.view.isUserInteractionEnabled = true
            })
        }
    }
    
    @objc func handleContinueTap() {
        let _ = textFieldShouldReturn(emailField)
        if (emailField.text?.count ?? 0) > 0 {
            self.activityIndicator.startAnimating()
            view.isUserInteractionEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {[weak self] in
                let alert = UIAlertController(title: "E-Mail login failed. ", message: "Try again later or use Google/Apple Login.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true, completion: { [weak self] in
                    self?.activityIndicator.stopAnimating()
                    self?.view.isUserInteractionEnabled = true
                })
            }
        }else {
            let alert = UIAlertController(title: "Please enter Email to continue", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        
        // Get the keyboard size from the notification
        let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        let keyboardHeight = keyboardFrame.height
        
        [titleLabel,leftDivider,rightDivider,googleButton, appleButton, orLabel, closeButton].forEach { view in
            view.isHidden = true
        }
        continueButton.isHidden = false
        continueButtonBottomConstraint?.constant = -keyboardHeight + 10
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        // Reset the bottom constraint to the original value
        continueButtonBottomConstraint?.constant = -20
        [titleLabel,leftDivider,rightDivider,googleButton, appleButton, orLabel, closeButton].forEach { view in
            view.isHidden = false
        }
        continueButton.isHidden = true
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    
}

extension LoginOptionsViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
