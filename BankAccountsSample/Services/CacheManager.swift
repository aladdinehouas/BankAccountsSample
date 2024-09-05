//
//  CacheManager.swift
//  BankAccountsSample
//
//  Created by Aladdin Houas on 05/09/2024.
//

import Foundation

class CacheManager {
    static let shared = CacheManager()  // Singleton pour le cache
    
    private let cacheExpirationInterval: TimeInterval = 60 * 120  // 5 minutes
    private var cachedBanks: [Bank]?
    private var cacheTimestamp: Date?

    // Méthode pour récupérer les banques en cache
    func getCachedBanks() -> [Bank]? {
        guard let timestamp = cacheTimestamp else { return nil }
        let timeElapsed = Date().timeIntervalSince(timestamp)
        
        // Vérifie si le cache est expiré
        if timeElapsed < cacheExpirationInterval {
            return cachedBanks
        } else {
            clearCache()
            return nil
        }
    }

    // Méthode pour mettre en cache les banques
    func cacheBanks(_ banks: [Bank]) {
        cachedBanks = banks
        cacheTimestamp = Date()
    }

    // Méthode pour effacer le cache
    func clearCache() {
        cachedBanks = nil
        cacheTimestamp = nil
    }
}
