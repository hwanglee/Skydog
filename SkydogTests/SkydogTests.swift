//
//  SkydogTests.swift
//  SkydogTests
//
//  Created by Hwang Lee on 7/11/22.
//

import XCTest
@testable import Skydog

class SkydogTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPlayPause() {
        let audioPlayer = AudioPlayer()
        let track = Track(uuid: "test",
                          url: "https://samplelib.com/lib/preview/mp3/sample-3s.mp3",
                          title: "test",
                          slug: "test",
                          trackPosition: 0)
        
        audioPlayer.play()
        XCTAssertFalse(audioPlayer.isPlaying)
        
        audioPlayer.setTrack(track: track)
        audioPlayer.play()
        
        XCTAssertTrue(audioPlayer.isPlaying)
        
        audioPlayer.pause()
        
        XCTAssertTrue(!audioPlayer.isPlaying)
    }

}
