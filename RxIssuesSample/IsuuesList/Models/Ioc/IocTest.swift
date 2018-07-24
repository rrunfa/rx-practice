//
//  IocTest.swift
//  RxIssuesSample
//
//  Created by Nikita Nagaynik on 24/07/2018.
//  Copyright © 2018 Nikita Nagaynik. All rights reserved.
//

import Foundation

protocol Animal {
    var name: String? { get }
    
    func voice() -> String
}

class Cat: Animal {
    
    let name: String?
    
    init(name: String?) {
        self.name = name
    }
    
    func voice() -> String {
        return "Mew mew"
    }
}

class Dog: Animal {
    
    let name: String?
    
    init(name: String?) {
        self.name = name
    }
    
    func voice() -> String {
        return "Woof woof"
    }
}
