//
//  DataLoaderTests.swift
//  SkydogTests
//
//  Created by Hwang Lee on 11/19/22.
//

import XCTest
@testable import Skydog

final class DataLoaderTests: XCTestCase {
    let artistSlug = "grateful-dead"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchArtists() async {
        let artists = (try? await DataLoader.shared.fetchArtists()) ?? []
        
        XCTAssertTrue(!artists.isEmpty)
    }

    func testFetchYears() async {
        let years = (try? await DataLoader.shared.fetchYears(artistSlug: artistSlug)) ?? []
        
        XCTAssertTrue(!years.isEmpty)
    }
    
    func testFetchShows() async {
        let shows = (try? await DataLoader.shared.fetchTopShows(artistSlug: artistSlug)) ?? []
        
        XCTAssertTrue(!shows.isEmpty)
    }
    
    func testFetchRecentShows() async {
        let shows = (try? await DataLoader.shared.fetchRecentShows(artistSlug: artistSlug)) ?? []
        
        XCTAssertTrue(!shows.isEmpty)
    }
}
