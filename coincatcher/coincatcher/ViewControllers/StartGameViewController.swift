//
//  StartGameViewController.swift
//  coincatcher
//
//  Created by Ramon Martinez on 4/10/24.
//

import UIKit

class StartGameViewController: UIViewController, StartViewDelegate, DataPresenterDelegate {
    
    var countCardView: CountCardView?
    var objectView: ObjectView?
    var dataPresenter: DataPresenter?
    var coinTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataPresenter = DataPresenter()
        dataPresenter?.delegate = self
        setupStarterView()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupStarterView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        countCardView?.removeFromSuperview()
        objectView?.removeFromSuperview()
        coinTimer?.invalidate()
    }
    
    func setupStarterView() {
        let startView = StartView()
        startView.delegate = self
        view.addSubview(startView)
        
        startView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            startView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            startView.topAnchor.constraint(equalTo: view.topAnchor),
            startView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func startCountDown() {
        var count = 3
        let countdownLabel = UILabel()
        countdownLabel.font = UIFont.systemFont(ofSize: 64, weight: .bold)
        countdownLabel.textColor = .black
        countdownLabel.textAlignment = .center
        countdownLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(countdownLabel)
        NSLayoutConstraint.activate([
            countdownLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countdownLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            countdownLabel.text = "\(count)"
            count -= 1
            
            if count < 0 {
                timer.invalidate()
                countdownLabel.removeFromSuperview()
                self.startGame()
            }
        }
            
    }
    
    // MARK: StartGame
    
    func startGame() {
        // Setting up the game
        
        countCardView = CountCardView()
        objectView = ObjectView()
        
        guard let countCardView = countCardView,
              let objectView = objectView else {
            return
        }

        view.addSubview(countCardView)
        countCardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            countCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            countCardView.widthAnchor.constraint(equalToConstant: 100),
            countCardView.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        // Use the existing instance of ObjectView
        objectView.isUserInteractionEnabled = true
        view.addSubview(objectView)
        objectView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            objectView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            objectView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70), // Adjust the constant as needed
        ])
        
        // Start spawning coins
        startCoinSpawner()
        dataPresenter?.startOverallTimer()
        
        // Debug output
        print("ObjectView added as a subview: \(objectView)")
    }
    
    func startCoinSpawner() {
        coinTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(spawnCoin), userInfo: nil, repeats: true)
    }
    
    @objc func spawnCoin() {
        guard let objectView = objectView, let countCardView = countCardView else { return }
        
        let coinImageView = UIImageView(image: UIImage(named: "coin"))
        coinImageView.contentMode = .scaleAspectFit
        coinImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            coinImageView.widthAnchor.constraint(equalToConstant: 25),
            coinImageView.heightAnchor.constraint(equalToConstant: 25),
        ])
        view.addSubview(coinImageView)
        
        let randomX = CGFloat.random(in: 50...(view.bounds.width - 50))
        coinImageView.centerXAnchor.constraint(equalTo: view.leadingAnchor, constant: randomX).isActive = true
        coinImageView.centerYAnchor.constraint(equalTo: objectView.topAnchor).isActive = true
        
        UIView.animate(withDuration: 5.0, animations: {
            coinImageView.frame.origin.y = self.view.bounds.height
        }) { _ in
            // Check collision after coin animation completes
            if objectView.checkCollision(with: coinImageView) {
                // Increment score or perform any other action
                print("Collision detected!")
                countCardView.count += 1 // Increment count
                countCardView.countLabel.text = "\(countCardView.count)" // Update label text
                coinImageView.removeFromSuperview()
            }
            coinImageView.removeFromSuperview()
        }
    }


    
    func setUpUI() {
        view.backgroundColor = .white
    }
        
    // MARK: StartViewDelegate
    
    func startButtonTapped() {
        view.subviews.forEach { $0.removeFromSuperview() }
        view.backgroundColor = .white
        startCountDown()
    }
    
    // MARK: DataPresenterDelegate
    
    func gameOver() {
        //TODO: FIX RENDERING ANIMATIONS AT THE BACKGROUND
        // Think of a way for dismiss the VC/ or stop the animations
        let popupViewController = GameOverViewController()
        popupViewController.modalPresentationStyle = .overFullScreen
        present(popupViewController, animated: false) { [weak self] in
            self?.view.isUserInteractionEnabled = true
        }
    }
}
