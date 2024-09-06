//
//  OperationListViewModel.swift
//  BankAccountsSample
//
//  Created by Aladdin Houas on 05/09/2024.
//

import Foundation

class OperationListViewModel: ObservableObject, Identifiable, Hashable {
    @Published var operations: [OperationViewModel] = []
    private let account: Account

    init(account: Account) {
        self.account = account
        if let operations = account.operations {
            self.operations = operations.sorted {
                // Convertir les dates String en Date pour comparer
                let date1 = convertToDate(from: $0.date) ?? Date.distantPast
                let date2 = convertToDate(from: $1.date) ?? Date.distantPast

                if date1 == date2 {
                    // Si les dates sont égales, trier par titre (ordre alphabétique)
                    return $0.title ?? "" < $1.title ?? ""
                }
                // Trier par date (du plus récent au plus ancien)
                return date1 > date2
            }.map(OperationViewModel.init)
        }
    }

    // Fonction pour convertir les timestamps Unix en Date
    func convertToDate(from timestamp: String?) -> Date? {
        guard let timestamp = timestamp, let timeInterval = TimeInterval(timestamp) else {
            return nil
        }
        return Date(timeIntervalSince1970: timeInterval)
    }

    // Hashable et Identifiable conformances
    static func == (lhs: OperationListViewModel, rhs: OperationListViewModel) -> Bool {
        return lhs.account.id == rhs.account.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(account.id)
    }
}
