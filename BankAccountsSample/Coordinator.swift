//
//  Coordinator.swift
//  BankAccountsSample
//
//  Created by Aladdin Houas on 05/09/2024.
//

import SwiftUI

//class Coordinator: ObservableObject {
//    @Published var navigationPath = NavigationPath()
//    
//    func showOperations(for account: Account) {
//        let viewModel = OperationListViewModel(account: account)
//        navigationPath.append(viewModel)
//    }
//}

import SwiftUI

class Coordinator: ObservableObject {
    @Published var navigationPath = NavigationPath()

    func showOperations(for account: Account) {
        let viewModel = OperationListViewModel(account: account)
        navigationPath.append(viewModel)
    }
}

//struct MainView: View {
//    @ObservedObject var coordinator = Coordinator()
//    
//    var body: some View {
//        NavigationStack(path: $coordinator.navigationPath) {
//            BankListView(viewModel: BankListViewModel(banks: loadBanks())) // loadBanks() retourne une liste de Bank
//                .navigationDestination(for: OperationListViewModel.self) { viewModel in
//                    OperationListView(viewModel: viewModel)
//                }
//        }
//    }
//}

struct MainView: View {
    @ObservedObject var coordinator = Coordinator()  // Créer une instance de Coordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            BankListView(viewModel: BankListViewModel(banks: loadBanks()), coordinator: coordinator)  // Passer le Coordinator à la BankListView
                .navigationDestination(for: OperationListViewModel.self) { viewModel in
                    OperationListView(viewModel: viewModel)
                }
        }
    }
}

func loadBanks() -> [Bank] {
    // Charger les banques depuis les données
    if let url = Bundle.main.url(forResource: "banks", withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let banks = try decoder.decode(Banks.self, from: data)
            return banks.banks ?? []
        } catch {
            print("Failed to load or decode JSON: \(error.localizedDescription)")
        }
    }
    return []
}
