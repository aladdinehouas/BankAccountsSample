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
    
    func loadBanks() async {
        DispatchQueue.main.async {
            self.isLoading = true
            self.errorMessage = nil
        }

        do {
            let banks = try await repository.getBanks()
            
            let creditAgricole = banks.filter { bank in
                if let isCA = bank.isCA {
                    let result = isCA == 1
                    return result
                }
                return false
            }
            
            let otherBanks = banks.filter { bank in
                if let isCA = bank.isCA {
                    let result = isCA != 1
                    return result
                }
                return false
            }
            
            // Tri et mapping
            self.creditAgricoleBanks = creditAgricole
                .sorted { ($0.name ?? "") < ($1.name ?? "") }
                .map(BankViewModel.init)
            self.otherBanks = otherBanks
                .sorted { ($0.name ?? "") < ($1.name ?? "") }
                .map(BankViewModel.init)
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.isLoading = false
                self.errorMessage = "Erreur de chargement des données"
            }
        }
    }
}
