//
//  Emoji.swift
//  EmojiMob
//
//  Created by Joseph Van Boxtel on 1/22/20.
//  Copyright © 2020 Joseph Van Boxtel. All rights reserved.
//

import Foundation

struct Emoji: Codable, Hashable, Identifiable {
//    {
//      "emoji": "😀"
//    , "description": "grinning face"
//    , "category": "Smileys & Emotion"
//    , "aliases": [
//        "grinning"
//      ]
//    , "tags": [
//        "smile"
//      , "happy"
//      ]
//    , "unicode_version": "6.1"
//    , "ios_version": "6.0"
//    }
    var id: String { character }
    enum CodingKeys: String, CodingKey {
        case character = "emoji"
        case description
    }
    
    var character: String
    var description: String
}
