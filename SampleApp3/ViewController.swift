//
//  ViewController.swift
//  SampleApp3
//
//  Created by Shivansh Sharma on 13/04/25.
//
import UIKit

class ViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let gifPlaceholderView = UIImageView()
    private let deviceButton = UIButton()
    private let noDeviceButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupTitle()
        setupMediaPlaceholder()
        setupButtons()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Sheet frame: \(view.frame)")
    }
    
    private func setupTitle() {
        titleLabel.text = "The brain fuel is already in your body—just get it flowing!"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        titleLabel.numberOfLines = 3
        titleLabel.textAlignment = .center
    }
    
    private func setupMediaPlaceholder() {
        gifPlaceholderView.image = UIImage(named: "continue-icon")
        gifPlaceholderView.contentMode = .scaleAspectFit
        gifPlaceholderView.layer.cornerRadius = 12
        gifPlaceholderView.clipsToBounds = true
    }
    
    private func setupButtons() {
        deviceButton.setTitle("I have a device", for: .normal)
        deviceButton.imageView?.contentMode = .scaleAspectFit
        deviceButton.backgroundColor = .white
        deviceButton.setTitleColor(.black, for: .normal)
        deviceButton.layer.cornerRadius = 8
        deviceButton.addTarget(self, action: #selector(handleIHaveADeviceTap), for: .touchUpInside)
        
        noDeviceButton.setTitle("I don’t have a device", for: .normal)
        noDeviceButton.setTitleColor(.white, for: .normal)
        noDeviceButton.layer.borderWidth = 1
        noDeviceButton.layer.borderColor = UIColor.white.cgColor
        noDeviceButton.layer.cornerRadius = 8
    }
    
    private func setupConstraints() {
        [titleLabel, gifPlaceholderView, deviceButton, noDeviceButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            gifPlaceholderView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            gifPlaceholderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gifPlaceholderView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            gifPlaceholderView.heightAnchor.constraint(equalToConstant: 200),
            
            deviceButton.bottomAnchor.constraint(equalTo: noDeviceButton.topAnchor, constant: -12),
            deviceButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            deviceButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            deviceButton.heightAnchor.constraint(equalToConstant: 50),
            
            noDeviceButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            noDeviceButton.leadingAnchor.constraint(equalTo: deviceButton.leadingAnchor),
            noDeviceButton.trailingAnchor.constraint(equalTo: deviceButton.trailingAnchor),
            noDeviceButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func handleIHaveADeviceTap() {
        let loginVC = LoginOptionsViewController()
        loginVC.delegate = self
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true)
    }
}

extension ViewController: LoginSuccess {
    func loginSuccess() {
        let homeVC = HomeViewController()
        self.navigationController?.pushViewController(homeVC, animated: false)
    }
}
