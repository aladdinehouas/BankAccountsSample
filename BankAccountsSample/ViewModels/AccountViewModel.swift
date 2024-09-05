//
//  AccountViewModel.swift
//  BankAccountsSample
//
//  Created by Aladdin Houas on 06/09/2024.
//

import Foundation
import Combine

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
