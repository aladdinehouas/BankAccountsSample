//
//  BankRepository.swift
//  BankAccountsSample
//
//  Created by Aladdin Houas on 05/09/2024.
//

import Foundation

protocol BankRepositoryProtocol {
    func getBanks() async throws -> [Bank]
}

class BankRepository: BankRepositoryProtocol {
    private let apiService: APIService
    private let cacheManager: CacheManager
    
    init(apiService: APIService = .shared, cacheManager: CacheManager = .shared) {
        self.apiService = apiService
        self.cacheManager = cacheManager
    }
    
    func getBanks() async throws -> [Bank] {
        // Vérifie si les banques sont disponibles en cache
        if let cachedBanks = cacheManager.getCachedBanks() {
            return cachedBanks
        }
        
        // Si non, fait un appel API
        let banks = try await apiService.fetchBanks()
        
        // Met les banques en cache après les avoir récupérées
        cacheManager.cacheBanks(banks)
        
        return banks
    }
}
