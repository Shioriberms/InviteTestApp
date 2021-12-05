//
//  UserViewModel.swift
//  InviteTest
//
//  Created by user210003 on 12/4/21.
//

import Foundation
import UIKit

extension InviteMembersView {
    class TeamViewModel: ObservableObject {
        @Published var team: Team?
        @Published var roleAvailability : [Helpers.Permission: Helpers.Availability]
        @Published var inviteLink : String
        
        private var service: WebService
        
        init(teamsID : String, selectedPermission : Helpers.Permission){
            self.service = WebService()
            self.roleAvailability = [Helpers.Permission: Helpers.Availability]()
            self.inviteLink = ""
            loadUser(teamsID: teamsID)
            getAvailableRoles()
            getInviteLink(permission: selectedPermission)
        }
        
        func loadUser(teamsID : String) {
            self.service.getUser(teamsID: teamsID){ (team) in
                self.team = team
            }
        }
        
        func getAvailableRoles()
        {
            self.roleAvailability = [Helpers.Permission: Helpers.Availability]()
            let totalMembers = self.team!.members.total
            let totalSupporters = self.team!.members.supporters
            let maxMembers = self.team!.plan.memberLimit
            let maxSupporters = self.team!.plan.supporterLimit
            
            //Check if there are available member slots
            if(totalMembers - totalSupporters < maxMembers){
                //Set all to enabled
                Helpers.Permission.allCases.forEach{
                    roleAvailability.updateValue(Helpers.Availability.enabled, forKey: $0)
                }
            }
            else{
                //Set all to disabled except
                Helpers.Permission.allCases.forEach{
                    roleAvailability.updateValue(Helpers.Availability.disabled, forKey: $0)
                }
            }

            //Check if Supporters are available
            // c1: supporter option not available
            // c2: max supporters reached
            // c3: supporters are available
            if(maxSupporters == 0){
                self.roleAvailability.updateValue(Helpers.Availability.hidden, forKey: Helpers.Permission.Supporter)
            }
            else if (totalSupporters == maxSupporters){
                self.roleAvailability.updateValue(Helpers.Availability.disabled, forKey: Helpers.Permission.Supporter)
            }
            else{
                self.roleAvailability.updateValue(Helpers.Availability.enabled, forKey: Helpers.Permission.Supporter)
            }
        }
        
        func getInviteLink(permission : Helpers.Permission)
        {
            var role : String = ""
            switch permission{
            case .Coach:
                role = Helpers.PermissionRoles.Coach.rawValue
            case .PlayerCoach:
                role = Helpers.PermissionRoles.PlayerCoach.rawValue
            case .Player:
                role = Helpers.PermissionRoles.Player.rawValue
            case .Supporter:
                role = Helpers.PermissionRoles.Supporter.rawValue
            }
            
            self.service.getURL(teamsID: team!.id, role: role){ (inviteLink) in
                self.inviteLink = inviteLink.url
            }
            
            //QR?
        }
    }
}
