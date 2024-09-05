//
//  APIService.swift
//  BankAccountsSample
//
//  Created by Aladdin Houas on 05/09/2024.
//

import Foundation

class APIService {
    static let shared = APIService()  // Singleton pour un accès global à l'API
    
    private init() {}
    
    func fetchBanks() async throws -> [Bank] {
        let url = URL(string: "https://cdf-test-mobile-default-rtdb.europe-west1.firebasedatabase.app/banks.json")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Vérifie la réponse HTTP
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        // Décode les données JSON en [Bank]
        let banks = try JSONDecoder().decode([Bank].self, from: data)
        return banks
    }
}
