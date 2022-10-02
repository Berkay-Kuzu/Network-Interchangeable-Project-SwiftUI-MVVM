//
//  Webservice.swift
//  NetworkInterchangable
//
//  Created by Berkay Kuzu on 25.09.2022.
//

import Foundation

// Hataları düzgün bir şekilde ele almak için enum oluşturuyorum:

enum NetworkError: Error {
    case invalidUrl
    case invalidServerResponse
}

class Webservice: NetworkService {
    
    var type: String = "Webservice"
    

    func download(_ resource: String) async throws -> [User] {
        
        // Öncelikle url'yi alıyorum:
        guard let url = URL(string: resource) else {
            throw NetworkError.invalidUrl
        }
        // Datayı alıyorum:
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else  {
                throw NetworkError.invalidServerResponse
            }
        
        //[User] döndürüyorum: Verimizi aldıktan sonra decode ediyorum.
        return try JSONDecoder().decode([User].self, from: data)
        }
    }
