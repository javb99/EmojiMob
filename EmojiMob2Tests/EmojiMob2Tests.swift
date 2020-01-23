//
//  EmojiMob2Tests.swift
//  EmojiMob2Tests
//
//  Created by Joseph Van Boxtel on 1/22/20.
//  Copyright © 2020 Joseph Van Boxtel. All rights reserved.
//

import XCTest
@testable import EmojiMob2

class EmojiMob2Tests: XCTestCase {

    func testDecode() {
       let input = """
            {
              "emoji": "😀"
            , "description": "grinning face"
            , "category": "Smileys & Emotion"
            , "aliases": [
                "grinning"
              ]
            , "tags": [
                "smile"
              , "happy"
              ]
            , "unicode_version": "6.1"
            , "ios_version": "6.0"
            }
            """
        let decoder = JSONDecoder()
        let emoji = try! decoder.decode(Emoji.self, from: input.data(using: .utf8)!)
        
        XCTAssertEqual(emoji.character, "😀")
        XCTAssertEqual(emoji.description, "grinning face")
    }
    
    func testDecodeFile() {
        let url = Bundle.main.url(forResource: "Data", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        
        XCTAssertNoThrow(try decoder.decode([Emoji].self, from: data))
    }
    
    func testEmojiService() {
        let expectation = self.expectation(description: "emoji service")
        let emojiService = EmojiService()
        var emojis: [Emoji]?
        
        emojiService.getEmojis { result in
            emojis = try? result.get()
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5000)
        XCTAssertNotNil(emojis)
    }

}
