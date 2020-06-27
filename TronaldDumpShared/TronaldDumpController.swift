//
//  TronaldDumpController.swift
//  TronaldDump
//
//  Created by Aritro Paul on 27/06/20.
//

import Foundation

struct Quote : Codable {
    var value: String?
}


class QuoteController {
    
    let url = URL(string: "https://tronalddump.io/random/quote")!
    static let shared = QuoteController()
    
    func getQuote(completion : @escaping(Quote)->Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            let quote = try! JSONDecoder().decode(Quote.self, from: data)
            completion(quote)
        }
        
        task.resume()
    }
    
}
