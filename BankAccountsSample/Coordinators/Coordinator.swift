//
//  Coordinator.swift
//  BankAccountsSample
//
//  Created by Aladdin Houas on 05/09/2024.
//

import SwiftUI

class Coordinator: ObservableObject {
    @Published var navigationPath = NavigationPath()

    func showOperations(for account: Account) {
        let viewModel = OperationListViewModel(account: account)
        navigationPath.append(viewModel)
    }
}
