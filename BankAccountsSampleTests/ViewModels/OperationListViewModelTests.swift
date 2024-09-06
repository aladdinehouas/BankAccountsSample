//
//  OperationListViewModelTests.swift
//  BankAccountsSampleTests
//
//  Created by Aladdin Houas on 06/09/2024.
//

import XCTest
@testable import BankAccountsSample

class OperationListViewModelTests: XCTestCase {

    func testOperationListViewModelInitialization() {
        // Créer des opérations avec les données nécessaires pour les tests
        let operations = [
            Operation(id: "1", title: "B", amount: "-15,99", category: "leisure", date: "1644784369"),
            Operation(id: "2", title: "A", amount: "-20,00", category: "shopping", date: "1644875600")
        ]
        
        // Créer un compte avec ces opérations
        let account = Account(
            order: 1,
            id: "1",
            holder: "John Doe",
            role: 1,
            contract_number: "1234",
            label: "Test Account",
            product_code: "XYZ",
            balance: 1000.0,
            operations: operations
        )
        
        // Créer une instance de `OperationListViewModel`
        let viewModel = OperationListViewModel(account: account)
        
        // Vérifier que les opérations sont triées correctement
        XCTAssertEqual(viewModel.operations.count, 2)
        XCTAssertEqual(viewModel.operations[0].title, "A")
        XCTAssertEqual(viewModel.operations[1].title, "B")
    }
    
    func testConvertToDate() {
        let viewModel = OperationListViewModel(account: Account())
        let date = viewModel.convertToDate(from: "1644784369")
        
        let expectedDate = Date(timeIntervalSince1970: 1644784369)
        XCTAssertEqual(date, expectedDate)
    }
    
    func testConvertToDateInvalidTimestamp() {
        let viewModel = OperationListViewModel(account: Account())
        let date = viewModel.convertToDate(from: "invalid")
        
        XCTAssertNil(date)
    }

    func testConvertToDateNilTimestamp() {
        let viewModel = OperationListViewModel(account: Account())
        let date = viewModel.convertToDate(from: nil)
        
        XCTAssertNil(date)
    }

    func testSortingOperations() {
        // Créer des opérations avec des dates et titres différents pour tester le tri
        let operations = [
            Operation(id: "1", title: "B", amount: "-15,99", category: "leisure", date: "1644784369"), // Plus récent
            Operation(id: "2", title: "A", amount: "-20,00", category: "shopping", date: "1644875600"), // Plus ancien
            Operation(id: "3", title: "C", amount: "-10,00", category: "shopping", date: "1644784369") // Même date que le premier, trié par titre
        ]
        
        // Créer un compte avec ces opérations
        let account = Account(
            order: 1,
            id: "1",
            holder: "John Doe",
            role: 1,
            contract_number: "1234",
            label: "Test Account",
            product_code: "XYZ",
            balance: 1000.0,
            operations: operations
        )
        
        // Créer une instance de `OperationListViewModel`
        let viewModel = OperationListViewModel(account: account)
        
        // Vérifier que les opérations sont triées par date (du plus récent au plus ancien) puis par titre (ordre alphabétique)
        XCTAssertEqual(viewModel.operations[0].title, "A")
        XCTAssertEqual(viewModel.operations[1].title, "B")
        XCTAssertEqual(viewModel.operations[2].title, "C")
    }
}
