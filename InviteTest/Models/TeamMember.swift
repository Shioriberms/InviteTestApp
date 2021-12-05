//
//  TeamMember.swift
//  InviteTest
//
//  Created by user210003 on 11/27/21.
//

import Foundation

struct TeamMember : Decodable{
    var total: Int
    var administrators: Int
    var managers: Int
    var editors: Int
    var members: Int
    var supporters: Int
}
