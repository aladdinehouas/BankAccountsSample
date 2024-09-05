//
//  MainView.swift
//  BankAccountsSample
//
//  Created by Aladdin Houas on 06/09/2024.
//

import SwiftUI

struct MainView: View {
    @StateObject var coordinator = Coordinator()  // Créer une instance de Coordinator
    @StateObject private var viewModel = BankListViewModel()

    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            if viewModel.isLoading {
                ProgressView("Chargement...")
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            } else {
                List {
                    Section(header: Text("Crédit Agricole")) {
                        ForEach(viewModel.creditAgricoleBanks) { bankVM in
                            BankCellView(viewModel: bankVM, coordinator: coordinator)
                        }
                    }

                    Section(header: Text("Autres Banques")) {
                        ForEach(viewModel.otherBanks) { bankVM in
                            BankCellView(viewModel: bankVM, coordinator: coordinator)
                        }
                    }
                }
                .navigationTitle("Comptes Bancaires")
                .navigationDestination(for: OperationListViewModel.self) { viewModel in
                    OperationListView(viewModel: viewModel)
                }
            }
        }
        .task {
            await viewModel.loadBanks()  // Appel asynchrone pour charger les banques
        }
    }
}
