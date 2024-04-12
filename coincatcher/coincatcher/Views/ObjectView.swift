//
//  ObjectView.swift
//  coincatcher
//
//  Created by Ramon Martinez on 4/11/24.
//

import UIKit

class ObjectView: UIView {
    
    private var countOrg: Int = 0
    private let slideDistance: CGFloat = 50 // Adjust this value as needed
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        startRandomMovements()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        startRandomMovements()
    }
    
    // Player Objects
    lazy var piggyBankView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "piggybank"))
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
        ])
        return imageView
    }()
    
    private func setupUI() {
        addSubview(piggyBankView)
        
        NSLayoutConstraint.activate([
            piggyBankView.centerXAnchor.constraint(equalTo: centerXAnchor),
            piggyBankView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func checkCollision(with coinImageView: UIImageView) -> Bool {
        guard let piggyBankFrame = piggyBankView.superview?.convert(piggyBankView.frame, to: nil),
              let coinFrame = coinImageView.superview?.convert(coinImageView.frame, to: nil) else {
            return false
        }
        
        let collision = piggyBankFrame.intersects(coinFrame)
        
        if collision {
            handleCollision() // Call a separate method to handle the collision
        }
        
        return collision
    }
    
    func handleCollision() {
        // Handle the collision, such as updating the score or performing other actions
        countOrg += 1
        print("Count updated in ObjectView:", countOrg)
    }
    
    private func startRandomMovements() {
        let duration = TimeInterval.random(in: 0.5...2.0) // Adjust the duration range as needed
        
        UIView.animate(withDuration: duration, animations: {
            self.randomizeMovement()
        }) { _ in
            // Animation completion handler, restart random movements recursively
            self.startRandomMovements()
        }
    }
    
    private func randomizeMovement() {
        let randomMovement = Bool.random()
        if randomMovement {
            piggyBankView.center.x -= slideDistance
        } else {
            piggyBankView.center.x += slideDistance
        }
    }
}
