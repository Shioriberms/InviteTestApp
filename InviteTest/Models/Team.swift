//
//  File.swift
//  InviteTest
//
//  Created by user210003 on 11/27/21.
//

import Foundation

struct Team : Decodable{
    var id: String
    var members: TeamMember
    var plan: Plan
}
