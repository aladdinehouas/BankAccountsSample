//
//  BankAccountsSampleTests.swift
//  BankAccountsSampleTests
//
//  Created by Aladdin Houas on 05/09/2024.
//

import XCTest
@testable import BankAccountsSample

final class BankListViewModelTests: XCTestCase {
    
    var mockRepository: MockBankRepository!
    var viewModel: BankListViewModel!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockBankRepository()
        viewModel = BankListViewModel(repository: mockRepository)
    }
    
    override func tearDown() {
        mockRepository = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testLoadBanks_Success() async {
        // Prépare des banques simulées
        let banks = [
            Bank(name: "Crédit Agricole", isCA: 1, accounts: []),
            Bank(name: "Banque Populaire", isCA: 0, accounts: [])
        ]
        
        mockRepository.banks = banks
        
        // Charge les banques
        await viewModel.loadBanks()
        
        // Vérifie que les banques sont triées et catégorisées correctement
        XCTAssertEqual(viewModel.creditAgricoleBanks.count, 1)
        XCTAssertEqual(viewModel.otherBanks.count, 1)
        XCTAssertEqual(viewModel.creditAgricoleBanks.first?.name, "Crédit Agricole")
        XCTAssertEqual(viewModel.otherBanks.first?.name, "Banque Populaire")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
}


class MockBankRepository: BankRepositoryProtocol {
    var banks: [Bank] = []
    var shouldReturnError = false
    
    func getBanks() async throws -> [Bank] {
        if shouldReturnError {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Error fetching banks"])
        }
        return banks
    }
}
