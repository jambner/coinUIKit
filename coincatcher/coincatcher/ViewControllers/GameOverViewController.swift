//
//  GameOverViewController.swift
//  coincatcher
//
//  Created by Ramon Martinez on 4/11/24.
//

import UIKit

class GameOverViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        // Popup container view
        let popupView = UIView()
        popupView.backgroundColor = .white
        popupView.layer.cornerRadius = 10
        popupView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(popupView)
        
        // Image Label
        
        
        
        // Title label
        let titleLabel = UILabel()
        titleLabel.text = "Game Over"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(titleLabel)
        
        // Description label
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Times Up!"
        descriptionLabel.textAlignment = .center
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(descriptionLabel)
        
        // Go Back button
        let goBackButton = UIButton(type: .system)
        goBackButton.setTitle("Go Back", for: .normal)
        goBackButton.addTarget(self, action: #selector(goBackButtonTapped), for: .touchUpInside)
        goBackButton.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(goBackButton)
        
        // Constraints
        NSLayoutConstraint.activate([
            popupView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popupView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popupView.widthAnchor.constraint(equalToConstant: 250),
            
            titleLabel.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -20),
            
            goBackButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            goBackButton.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 20),
            goBackButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -20),
            goBackButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -20)
        ])
    }
    
    @objc func goBackButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
