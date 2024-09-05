//
//  BankListView.swift
//  BankAccountsSample
//
//  Created by Aladdin Houas on 05/09/2024.
//

import SwiftUI

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
