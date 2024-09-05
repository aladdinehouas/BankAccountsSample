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

    init(banks: [Bank]) {
        self.creditAgricoleBanks = banks.filter { $0.isCA == 1 }.sorted { $0.name ?? "" < $1.name ?? "" }.map(BankViewModel.init)
        self.otherBanks = banks.filter { $0.isCA != 1 }.sorted { $0.name ?? "" < $1.name ?? "" }.map(BankViewModel.init)
    }
}

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

class AccountViewModel: Identifiable {
    let account: Account
    
    var id: String {
        return account.id ?? UUID().uuidString
    }
    
    var label: String {
        return account.label ?? "Unknown Account"
    }
    
    init(account: Account) {
        self.account = account
    }
}
