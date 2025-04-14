//
//  LaunchManager.swift
//  ContinueProject
//
//  Created by Shivansh Sharma on 14/04/25.
//

import Foundation

class LaunchManager {
    static let shared = LaunchManager()
    private let introKey = "hasSeenIntro"

    func markIntroSeen() {
        UserDefaults.standard.set(true, forKey: introKey)
    }

    func shouldShowIntro() -> Bool {
        return !UserDefaults.standard.bool(forKey: introKey)
    }
}
