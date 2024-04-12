//
//  ViewController.swift
//  coincatcher
//
//  Created by Ramon Martinez on 4/10/24.
//

import UIKit

class MainViewController: UIViewController {
    var gameVC = StartGameViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
       setupViews()
    }
    
    
    lazy var playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Play", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func playButtonTapped() {
        print("Tapped lol")
        navigationController?.pushViewController(gameVC, animated: true)
    }


    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(playButton)
        
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 200),
            playButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

