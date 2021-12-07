//
//  PopupView.swift
//  InviteTest
//
//  Created by user210003 on 11/28/21.
//

import SwiftUI


//struct pTypes{
//    return
//
//}
struct PopupView: View {
    @Binding var selectedPermission: Helpers.Permission!
    @Binding var showPopup: Bool
    @Binding var permissionAvailability: [Helpers.Permission: Helpers.Availability]
    
    var body: some View {
        
//        let permissionTypes =  ["Coach" : "manager", "Player Coach" : "editor", "Player" : "member", "Supporter" : "readonly"]
        ZStack
        {
            Rectangle()
                .foregroundColor(Color.white.opacity(0.2))
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    self.showPopup = false
                }
            VStack{
                ForEach(self.permissionAvailability.sorted(by: >), id: \.key)
                {
                    key, value in
                    
                    switch value {
                    case Helpers.Availability.enabled:
                        Button(action:{
                            self.selectedPermission = key
                            self.showPopup = false
                        })
                        {
                            Text(key.rawValue)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding(.vertical, 5.0)
                                .foregroundColor(Color.blue)
                        }
                    case Helpers.Availability.disabled:
                        Text(key.rawValue)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(.vertical, 5.0)
                            .foregroundColor(Color.gray)
                    case .hidden:
                        EmptyView()
                    }
                }
            }
            
            .frame(width: 300, alignment: .center)
            .background(Color.white)
        }
    }
}

struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView(selectedPermission: .constant(Helpers.Permission.Coach), showPopup: .constant(true), permissionAvailability: .constant([Helpers.Permission.Coach:Helpers.Availability.enabled]))
    }
}
