//
//  EmojiService.swift
//  EmojiMob
//
//  Created by Joseph Van Boxtel on 1/22/20.
//  Copyright © 2020 Joseph Van Boxtel. All rights reserved.
//

import Foundation

class EmojiService {
    func getEmojis(_ completion: @escaping (Result<[Emoji], Error>) -> Void) {
        do {
            let url = Bundle.main.url(forResource: "Data", withExtension: "json")!
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            
            let emojis = try decoder.decode([Emoji].self, from: data)
        
            completion(.success(emojis))
        } catch {
            completion(.failure(error))
        }
    }
}
