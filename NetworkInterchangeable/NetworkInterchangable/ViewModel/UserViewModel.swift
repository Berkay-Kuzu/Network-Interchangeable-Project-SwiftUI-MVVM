//
//  UserViewModel.swift
//  NetworkInterchangable
//
//  Created by Berkay Kuzu on 25.09.2022.
//

import Foundation

class UserListViewModel: ObservableObject {
    
    @Published var userList = [UserViewModel]() // Sadece UserViewModel struct'ının içindekiler gözükecek!
    // İnternetten indirdiklerimizi UserViewModel olarak buraya kaydedeceğiz.
    
    //let webservice =  Webservice()
    
    private var service : NetworkService
    init(service: NetworkService) {
        self.service = service
    }
    
    func downloadUsers() async {
        
        var resource = ""
        if service.type == "Webservice" {
            resource = Constants.Urls.usersExtension
        } else {
            resource = Constants.Path.baseUrl
        }
        
        do {
            let users =  try await service.download(resource)
            DispatchQueue.main.async {
                self.userList = users.map(UserViewModel.init)
            }
        } catch {
            print(error)
        }
    }
}

struct UserViewModel { // Kullanıcının sadece bu verilerini alıyorum.
    
    let user : User
    
    var id : Int {
        user.id
    }
    
    var name : String {
        user.name
    }
    
    var username : String {
        user.username
    }
    
    var email : String {
        user.email
    }
}
