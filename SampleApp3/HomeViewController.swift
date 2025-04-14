//
//  HomeViewController.swift
//  SampleApp3
//
//  Created by Shivansh Sharma on 14/04/25.
//
import UIKit

class HomeViewController: UIViewController {
    
    private let loadingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "Loading your details. \nHang Tight!"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "We are crafting the best possible experience for you!"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.setNavigationBarHidden(true, animated: true)
        setupLayout()
        activityIndicator.startAnimating()
    }

    private func setupLayout() {
        view.addSubview(loadingLabel)
        view.addSubview(secondLabel)
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            secondLabel.topAnchor.constraint(equalTo: loadingLabel.bottomAnchor, constant: 20),
            secondLabel.centerXAnchor.constraint(equalTo: loadingLabel.centerXAnchor),
            
            activityIndicator.bottomAnchor.constraint(equalTo: loadingLabel.topAnchor, constant: -20),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
