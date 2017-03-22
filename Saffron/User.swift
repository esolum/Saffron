//
//  User.swift
//  Saffron
//
//  Created by Erica Solum on 3/3/17.
//  Copyright © 2017 Erica Solum. All rights reserved.
//

import Foundation

class User{
    private var id: String
    private var username: String
    private var name: String
    private var isChef: Bool
    private var email: String
    
    init(id: String, username: String, name: String, isChef: Bool, email: String){
        self.id = id
        self.username = username
        self.name = name
        self.isChef = isChef
        self.email = email
    }
}
