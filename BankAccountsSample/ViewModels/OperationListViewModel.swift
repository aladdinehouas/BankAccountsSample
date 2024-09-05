//
//  OperationListViewModel.swift
//  BankAccountsSample
//
//  Created by Aladdin Houas on 05/09/2024.
//

import Foundation

class OperationListViewModel: ObservableObject, Identifiable, Hashable {
    @Published var operations: [OperationViewModel] = []
    private let account: Account  // Utilisé pour comparaison dans Hashable

    init(account: Account) {
        self.account = account
        if let operations = account.operations {
            self.operations = operations.sorted {
                if $0.date == $1.date {
                    return $0.title ?? "" < $1.title ?? ""
                }
                return $0.date ?? "" > $1.date ?? ""
            }.map(OperationViewModel.init)
        }
    }

    static func == (lhs: OperationListViewModel, rhs: OperationListViewModel) -> Bool {
        return lhs.account.id == rhs.account.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(account.id)
    }
}

class OperationViewModel: Identifiable {
    let operation: Operation
    
    var id: String {
        return operation.id ?? UUID().uuidString
    }
    
    var title: String {
        return operation.title ?? "Unknown Operation"
    }
    
    var amount: String {
        return operation.amount ?? "0"
    }
    
    var category: String {
        return operation.category ?? "Uncategorized"
    }
    
    var date: String {
        return operation.date ?? ""
    }
    
    init(operation: Operation) {
        self.operation = operation
    }
}
