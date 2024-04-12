//
//  DataPresenter.swift
//  coincatcher
//
//  Created by Ramon Martinez on 4/11/24.
//

import Foundation

protocol DataPresenterDelegate: AnyObject {
    func gameOver()
}

class DataPresenter {
    
    weak var delegate: DataPresenterDelegate?
    var overallTimer: Timer?
    let gameDuration: TimeInterval = 200 // 1 minute
    var countCardView: CountCardView?

    
    func startOverallTimer() {
        overallTimer = Timer.scheduledTimer(timeInterval: gameDuration, target: self, selector: #selector(gameOver), userInfo: nil, repeats: false)
    }
    
    @objc func gameOver() {
        // Invalidate the timer
        overallTimer?.invalidate()
        overallTimer = nil
        
        // Notify the delegate (StartGameViewController) that the game is over
        delegate?.gameOver()
    }
}

