//
//  GithubEndpoint.swift
//  RxPractice
//
//  Created by Nikita Nagaynik on 23/07/2018.
//  Copyright © 2018 Nikita Nagaynik. All rights reserved.
//

import Foundation
import Moya

enum GitHub {
    case userProfile(username: String)
    case repos(username: String)
    case repo(fullName: String)
    case issues(repositoryFullName: String)
}

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

extension GitHub: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .repos(let username):
            return "/users/\(username)/repos"
        case .userProfile(let username):
            return "/users/\(username)"
        case .repo(let fullName):
            return "/repos/\(fullName)"
        case .issues(let repositoryFullName):
            return "/repos/\(repositoryFullName)/issues"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        switch self {
        case .repos(_):
            return "{{\"id\": \"1\", \"language\": \"Swift\", \"url\": \"https://api.github.com/repos/mjacko/Router\", \"name\": \"Router\"}}}".data(using: .utf8)!
        case .userProfile(let name):
            return "{\"login\": \"\(name)\", \"id\": 100}".data(using: .utf8)!
        case .repo(_):
            return "{\"id\": \"1\", \"language\": \"Swift\", \"url\": \"https://api.github.com/repos/mjacko/Router\", \"name\": \"Router\"}".data(using: .utf8)!
        case .issues(_):
            return "{\"id\": 132942471, \"number\": 405, \"title\": \"Updates example with fix to String extension by changing to Optional\", \"body\": \"Fix it pls.\"}".data(using: .utf8)!
        }
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}
