//
//  BankViewModel.swift
//  BankAccountsSample
//
//  Created by Aladdin Houas on 06/09/2024.
//

import Foundation
import Combine

class BankViewModel: ObservableObject, Identifiable {
    @Published var isExpanded: Bool = false
    let bank: Bank
    
    var id: UUID {
        return bank.id
    }
    
    var name: String {
        return bank.name ?? "Unknown Bank"
    }
    
    var accounts: [AccountViewModel] {
        return (bank.accounts ?? []).sorted { $0.label ?? "" < $1.label ?? "" }.map(AccountViewModel.init)
    }
    
    init(bank: Bank) {
        self.bank = bank
    }
}
