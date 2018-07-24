//
//  Issue.swift
//  RxIssuesSample
//
//  Created by Nikita Nagaynik on 23/07/2018.
//  Copyright © 2018 Nikita Nagaynik. All rights reserved.
//

import Foundation
import Mapper

struct Issue: Mappable {
    
    let identifier: Int
    let number: Int
    let title: String
    let body: String
    
    init(_ id: Int, _ number: Int, _ title: String) {
        self.identifier = id
        self.number = number
        self.title = title
        self.body = ""
    }
    
    init(map: Mapper) throws {
        try identifier = map.from("id")
        try number = map.from("number")
        try title = map.from("title")
        try body = map.from("body")
    }
    
    var descr: String {
        return "Id: \(identifier) - Num: \(number)"
    }
}
