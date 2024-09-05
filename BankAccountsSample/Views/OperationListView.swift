//
//  OperationListView.swift
//  BankAccountsSample
//
//  Created by Aladdin Houas on 05/09/2024.
//

import SwiftUI

struct OperationListView: View {
    @ObservedObject var viewModel: OperationListViewModel
    
    var body: some View {
        List(viewModel.operations) { operationVM in
            HStack {
                VStack(alignment: .leading) {
                    Text(operationVM.title)
                    Text(operationVM.date).font(.subheadline).foregroundColor(.gray)
                }
                Spacer()
                Text(operationVM.amount)
            }
        }
        .navigationTitle("Opérations")
    }
}
