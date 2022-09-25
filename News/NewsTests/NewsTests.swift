//
//  NewsTests.swift
//  NewsTests
//
//  Created by Zensar on 24/09/22.
//

import XCTest
@testable import News
final class NewsTests: XCTestCase {
  
    func test_newsViewModal_should_show_valid_response() {
        let viewModel = NewsViewModel()
        let expectation = expectation(description: "test viewModel")
        viewModel.serviceHandler.getNews { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let news):
                    XCTAssertNil(news)
                case .failure(let error):
                    XCTAssertNil(error)
                }
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
