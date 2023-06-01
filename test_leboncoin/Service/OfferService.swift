//
//  OfferService.swift
//  test_leboncoin
//
//  Created by Perso on 5/30/23.
//

import Foundation

class OfferService: NSObject {
    
    func getOffers(completion: @escaping ([Offer]) -> ()) {
        guard let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        
        URLSession.shared.dataTask(with: request) { data, response, error -> Void in
            if let httpResponse = response as? HTTPURLResponse {
                if let data = data, httpResponse.statusCode.isValidResponse() {
                    let jsonDecoder = JSONDecoder()
                    let emptData = try! jsonDecoder.decode([Offer].self, from: data)
                    completion(emptData)
                }else {
                    print("error 2 to handle")
                }
            } else {
                print("error to handle")
            }
        }.resume()
    }
    
    func getCategories(completion: @escaping ([Category]) -> ()) {
        guard let url = URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        
        URLSession.shared.dataTask(with: request) { data, response, error -> Void in
            if let httpResponse = response as? HTTPURLResponse {
                if let data = data, httpResponse.statusCode.isValidResponse() {
                    let jsonDecoder = JSONDecoder()
                    let emptData = try! jsonDecoder.decode([Category].self, from: data)
                    completion(emptData)
                }else {
                    print("error 2 to handle")
                }
            } else {
                print("error to handle")
            }
        }.resume()
    }
}

extension Int {
    func isValidResponse() -> Bool {
        return self > 199 && self < 300
    }
}

