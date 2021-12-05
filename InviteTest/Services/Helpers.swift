//
//  Helpers.swift
//  InviteTest
//
//  Created by user210003 on 12/5/21.
//

import Foundation

struct Helpers{

    enum PermissionRoles : String {
        case Coach = "manager"
        case PlayerCoach = "editor"
        case Player = "member"
        case Supporter = "readonly"
        
    }
    
    enum Availability : Comparable{
        case disabled
        case hidden
        case enabled
    }

    enum Permission : String, CaseIterable, Comparable{
        static func < (lhs: Helpers.Permission, rhs: Helpers.Permission) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
        
        case Coach = "Coach"
        case PlayerCoach = "Player Coach"
        case Player = "Player"
        case Supporter = "Supporter"
    }

}
