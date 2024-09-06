//
//  OperationViewModel.swift
//  BankAccountsSample
//
//  Created by Aladdin Houas on 06/09/2024.
//

import Foundation

class OperationViewModel: Identifiable {
    let operation: Operation
    
    var operationId: String {
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
    
    var dateObject: Date? {
        if let date = operation.date, let timeInterval = TimeInterval(date) {
            return Date(timeIntervalSince1970: timeInterval)
        }
        return nil
    }
    
    init(operation: Operation) {
        self.operation = operation
    }
}
