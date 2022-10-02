//
//  NetworkService.swift
//  NetworkInterchangable
//
//  Created by Berkay Kuzu on 25.09.2022.
//

import Foundation

//NetworkService, bizim protokolümüz olacak. Hem network service hem local service network service'e uyum sağalayacak.

protocol NetworkService {
    
    func download(_ resource: String) async throws -> [User]
    var type : String {get}
}
