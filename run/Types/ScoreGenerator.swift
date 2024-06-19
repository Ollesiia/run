//
//  ScoreGenerator.swift
//  run
//
//  Created by Олеся Скидан on 07.05.2024.
//

import Foundation

class ScoreGenerator {
    static let shared = ScoreGenerator()
    
    static let sharedInstance = ScoreGenerator()
    private init() {}
    private let defaults = UserDefaults.standard
    
    static let keyHighScore = "keyHighScore"
    static let keyScore = "keyScore"
    private let userIDKey = K.WebView.userIDKey
    private let fullrefKey = K.WebView.fullrefKey
    
    func setScore(_ score: Int) {
        UserDefaults.standard.set(score, forKey: ScoreGenerator.keyScore)
    }
    
    func getScore() -> Int {
        return UserDefaults.standard.integer(forKey: ScoreGenerator.keyScore)
    }
    
    func setHighScore(_ score: Int) {
        UserDefaults.standard.set(score, forKey: ScoreGenerator.keyHighScore)
    }
    
    func getHighScore() -> Int {
        return UserDefaults.standard.integer(forKey: ScoreGenerator.keyHighScore)
    }
    
    func getUserID() -> String? {
        return defaults.string(forKey: userIDKey)
    }
    
    func setUserID(_ userID: String) {
        defaults.set(userID, forKey: userIDKey)
    }
    
    func getFullRef() -> String? {
        return defaults.string(forKey: fullrefKey)
    }
    
    func setFullRef(_ fullRef: String) {
        defaults.set(fullRef, forKey: fullrefKey)
    }
}
