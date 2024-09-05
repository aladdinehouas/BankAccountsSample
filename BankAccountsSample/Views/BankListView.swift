//
//  BankListView.swift
//  BankAccountsSample
//
//  Created by Aladdin Houas on 05/09/2024.
//

import SwiftUI

//struct BankListView: View {
//    @ObservedObject var viewModel: BankListViewModel
//    
//    var body: some View {
//        List {
//            Section(header: Text("Crédit Agricole")) {
//                ForEach(viewModel.creditAgricoleBanks) { bankVM in
//                    BankCellView(viewModel: bankVM)
//                }
//            }
//            
//            Section(header: Text("Autres Banques")) {
//                ForEach(viewModel.otherBanks) { bankVM in
//                    BankCellView(viewModel: bankVM)
//                }
//            }
//        }
//        .navigationTitle("Comptes Bancaires")
//    }
//}

struct BankListView: View {
    @ObservedObject var viewModel: BankListViewModel
    @ObservedObject var coordinator: Coordinator  // Passer le Coordinator ici

    var body: some View {
        List {
            Section(header: Text("Crédit Agricole")) {
                ForEach(viewModel.creditAgricoleBanks) { bankVM in
                    BankCellView(viewModel: bankVM, coordinator: coordinator)  // Passer le Coordinator à chaque BankCellView
                }
            }
            
            Section(header: Text("Autres Banques")) {
                ForEach(viewModel.otherBanks) { bankVM in
                    BankCellView(viewModel: bankVM, coordinator: coordinator)
                }
            }
        }
        .navigationTitle("Comptes Bancaires")
    }
}

//struct BankCellView: View {
//    @ObservedObject var viewModel: BankViewModel
//    
//    var body: some View {
//        DisclosureGroup(isExpanded: $viewModel.isExpanded) {
//            ForEach(viewModel.accounts) { accountVM in
//                Text(accountVM.label)
//            }
//        } label: {
//            Text(viewModel.name)
//        }
//    }
//}

struct BankCellView: View {
    @ObservedObject var viewModel: BankViewModel
    @ObservedObject var coordinator: Coordinator  // Ajout du Coordinator ici

    var body: some View {
        DisclosureGroup(isExpanded: $viewModel.isExpanded) {
            ForEach(viewModel.accounts) { accountVM in
                Button(action: {
                    coordinator.showOperations(for: accountVM.account)  // Appelle la navigation
                }) {
                    Text(accountVM.label)
                }
            }
        } label: {
            Text(viewModel.name)
        }
    }
}
