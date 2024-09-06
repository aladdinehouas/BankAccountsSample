//
//  BankListViewModel.swift
//  BankAccountsSample
//
//  Created by Aladdin Houas on 05/09/2024.
//

import Foundation
import Combine

class BankListViewModel: ObservableObject {
    @Published var creditAgricoleBanks: [BankViewModel] = []
    @Published var otherBanks: [BankViewModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let repository: BankRepositoryProtocol
    
    init(repository: BankRepositoryProtocol = BankRepository()) {
        self.repository = repository
    }
    
    // Fonction pour charger les banques
    func loadBanks() async {
        DispatchQueue.main.async {
            self.isLoading = true
            self.errorMessage = nil
        }
        
        do {
            let banks = try await repository.getBanks()
            print("Banks received in loadBanks: \(banks)")
            
            DispatchQueue.main.async {
                self.creditAgricoleBanks = banks
                    .filter { bank in
                        if let isCA = bank.isCA {
                            return isCA == 1
                        }
                        return false
                    }
                    .sorted { ($0.name ?? "") < ($1.name ?? "") }  // Tri alphabétique
                    .map(BankViewModel.init)
                
                self.otherBanks = banks
                    .filter { bank in
                        if let isCA = bank.isCA {
                            return isCA != 1
                        }
                        return false
                    }
                    .sorted { ($0.name ?? "") < ($1.name ?? "") }  // Tri alphabétique
                    .map(BankViewModel.init)
                
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.isLoading = false
                self.errorMessage = "Erreur de chargement des données"
            }
        }
        
        print("Crédit Agricole Banks: \(self.creditAgricoleBanks)")
        print("Other Banks: \(self.otherBanks)")
    }
}
