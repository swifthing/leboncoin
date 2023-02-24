//
//  LeBonCoinTests.swift
//  LeBonCoinTests
//
//  Created by Anis on 17/02/2023.
//

import XCTest
import Combine
@testable import LeBonCoin

final class LeBonCoinTests: XCTestCase {
    private var mockURL: URL?

    override func setUp() {
        super.setUp()
        mockURL = Bundle.main.url(forResource: "MockAPI", withExtension: "json")
    }

    func testShouldSuccessWhenJsonIsCorrectlyDecoded () throws {
        guard let fileURL = mockURL else { fatalError("Error with bundle file") }
        let sampleData = try JSONDecoder().decode([ClassifiedAdDTO].self, from: Data(contentsOf: fileURL))

        let network = Networkr()

        Task {
            let classifiedAdDTO: [ClassifiedAdDTO] = try await network.fetchData(URLRequest(url: fileURL))
            XCTAssertEqual(sampleData, classifiedAdDTO)
        }
    }

    func testShouldFailWhenJsonIsNotCorrectlyDecoded () throws {
        guard let fileURL = mockURL else { fatalError("Error with bundle file") }
        let sampleData = try JSONDecoder().decode([ClassifiedAdDTO].self, from: Data(contentsOf: fileURL))

        let network = Networkr()

        Task {
            let classifiedAdDTO: ClassifiedAdDTO = try await network.fetchData(URLRequest(url: fileURL))
            XCTAssertNotEqual(sampleData, [classifiedAdDTO])
        }
    }

    func testShouldSuccessWhenAdsMockIsCorrect () throws {
        // GIVEN
        let mockAdsRepository = MockAdsRepository()
        let homeViewModel: HomeViewModel = HomeViewModel(classifiedAdsRepository: mockAdsRepository)
        let promise = expectation(description: #function)

        Task {
            let valueFromViewModel = try await homeViewModel.classifiedAdsRepository.fetch()
            let valueFromMock = mockAdsRepository.fetch()
            // THEN
            XCTAssertEqual(valueFromViewModel, valueFromMock)
            promise.fulfill()
        }

        // WHEN
        waitForExpectations(timeout: 0.1)
    }

    func testFailSuccessWhenAdsMockIsNotCorrect () throws {
        // GIVEN
        let mockAdsRepository = MockAdsRepository()
        let homeViewModel: HomeViewModel = HomeViewModel(classifiedAdsRepository: mockAdsRepository)
        let promise = expectation(description: #function)

        Task {
            let valueFromViewModel = try await homeViewModel.classifiedAdsRepository.fetch()
            // THEN
            XCTAssertNotEqual(valueFromViewModel, [])
            promise.fulfill()
        }

        // WHEN
        waitForExpectations(timeout: 0.1)
    }

    func testShouldSuccessWhenCategoriesMockIsCorrect () throws {
        // GIVEN
        let mockCategorieRepository = MockCategorieRepository()
        let homeViewModel: HomeViewModel = HomeViewModel(categoriesRepository: mockCategorieRepository)
        let promise = expectation(description: #function)

        Task {
            let valueFromViewModel = try await homeViewModel.categoriesRepository.fetch()
            let valueFromMock = mockCategorieRepository.fetch()
            // THEN
            XCTAssertEqual(valueFromViewModel, valueFromMock)
            promise.fulfill()
        }

        // WHEN
        waitForExpectations(timeout: 0.1)
    }

    func testShouldFailWhenCategoriesMockIsNotCorrect () throws {
        // GIVEN
        let mockCategorieRepository = MockCategorieRepository()
        let homeViewModel: HomeViewModel = HomeViewModel(categoriesRepository: mockCategorieRepository)
        let promise = expectation(description: #function)

        Task {
            let valueFromViewModel = try await homeViewModel.categoriesRepository.fetch()
            // THEN
            XCTAssertNotEqual(valueFromViewModel, [])
            promise.fulfill()
        }

        // WHEN
        waitForExpectations(timeout: 0.1)
    }
}

fileprivate final class MockAdsRepository: ClassifiedAdsRepositoryProtocol {

    let classifiedAd: [ClassifiedAd] = [ClassifiedAd(id: 0, category_id: 0, title: "", description: "", price: 1),
                                        ClassifiedAd(id: 1, category_id: 2, title: "", description: "", price: 2),
                                        ClassifiedAd(id: 3, category_id: 3, title: "", description: "", price: 3)]

    func fetch() -> [ClassifiedAd] {
        classifiedAd
    }
}

extension Categorie: Equatable {
    public static func == (lhs: Categorie, rhs: Categorie) -> Bool {
        lhs.id == rhs.id
    }
}

fileprivate final class MockCategorieRepository: CategoriesRepositoryProtocol {

    let categories: [Categorie] = [Categorie(id: 1, name: "title1"),
                                   Categorie(id: 2, name: "title2")]


    func fetch() -> [Categorie] {
        categories
    }
}

extension ClassifiedAd: Equatable {
    public static func == (lhs: ClassifiedAd, rhs: ClassifiedAd) -> Bool {
        lhs.id == rhs.id
    }
}
