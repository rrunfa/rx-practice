//
//  MappableIssue.swift
//  RxIssuesSample
//
//  Created by Nikita Nagaynik on 24/07/2018.
//  Copyright © 2018 Nikita Nagaynik. All rights reserved.
//

import Foundation
import Mapper

protocol MappableIssue: Mappable {
    
    var descr: String {get}
}
