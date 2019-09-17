//
//  Book.swift
//  Reading List
//
//  Created by macbook on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation


struct Book: Equatable, Codable {
    
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    
    init(title: String, reasonToRead: String, hasBeenRead: Bool = false) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = false
        
    }
    
}
