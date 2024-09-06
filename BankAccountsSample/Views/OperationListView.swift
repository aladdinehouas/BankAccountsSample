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
                    Text(operationVM.amount)
                }
                Spacer()
                // Affichage de la date formatée
                if let date = operationVM.dateObject {
                    Text("\(date, formatter: operationDateFormatter)")
                }
            }
        }
        .navigationTitle("Opérations")
    }
}


// DateFormatter pour afficher la date dans un format lisible
private let operationDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()
