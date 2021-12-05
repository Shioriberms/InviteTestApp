//
//  SwiftUIView.swift
//  InviteTest
//
//  Created by user210003 on 11/27/21.
//

import SwiftUI


struct InviteMembersView: View {
    init(teamsID : String){
        Theme.navigationBarColors(background: .black, titleColor: .white)
        self.teamsID = teamsID
        self.selectedPermission = Helpers.Permission.Coach
        self.teamVM = TeamViewModel(teamsID: teamsID, selectedPermission: Helpers.Permission.Coach)
    }
    
    @ObservedObject var teamVM: TeamViewModel
    @State private var selectedPermission: Helpers.Permission = Helpers.Permission.Coach
    
    @State private var showPermissionTypes: Bool =  false
    @State private var teamsID: String

    var body: some View {
        
//        let hasSupporters = false
//        let permissionAvailability = userVM.roleAvailability
        
        NavigationView {
            ZStack
            {
                VStack
                {
                    HStack(alignment: .top){
                        Text("Current Members ")
                        Text(String(teamVM.team!.members.total))
                        Spacer()
                        Text("Limit ")
                        Text(String(teamVM.team!.plan.memberLimit))
                    }
                    if(teamVM.roleAvailability[Helpers.Permission.Supporter]! as Helpers.Availability != Helpers.Availability.hidden)
                    {
                        HStack
                        {
                            HStack(alignment: .top){
                                Text("Current Supporters ")
                                Text(String(teamVM.team!.members.supporters))
                                Spacer()
                                Text("Limit ")
                                Text(String(teamVM.team!.plan.supporterLimit))
                            }
                        }
                    }
                    
                    HStack
                    {
                        Text("Invite Permissions")
                        Spacer()
                    }
                   
                    Button(action: {showPermissionTypes = true}) {
                        HStack
                        {
                            Text(selectedPermission.rawValue)
                                .onChange(of: selectedPermission) { newValue in
                                    self.teamVM.getInviteLink(permission: selectedPermission)
                                }
                            
                            Spacer()
                            Image(systemName: "chevron.down")
                        }
                        .padding(.leading)
                        
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.all, 10.0)
                    .border(Color.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 2, style: .continuous))

                    Text("Invite URLs are valid for 7 days. Permissions can be changed from the member management view.")
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 2.0)
                    
                    Text("What are Permissions?")
                        .padding(.bottom, 2.0)
                        .font(.system(size: 20))
                    
                    Button(action: {}) {
                        Text("Share QR Code")
                    }.buttonStyle(Theme.ButtonFormat())
                    
                    Button(action: {
                        UIPasteboard.general.string = teamVM.inviteLink
                    }) {
                        Text("Copy Link")
                    }.buttonStyle(Theme.ButtonFormat())
                    
                    Spacer()
                }
                .blur(radius: self.showPermissionTypes ? 1 : 0)
                
                if $showPermissionTypes.wrappedValue {
                    PopupView(selectedPermission: $selectedPermission, showPopup: $showPermissionTypes, permissionAvailability: $teamVM.roleAvailability)
                }
            }
            .padding(.all)
            .navigationBarTitle("InviteMembers", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                HStack{
                    Text("Back").foregroundColor(.white)
                })

        }
        .foregroundColor(Color.gray)
        .onAppear(perform: {
            teamVM.loadUser(teamsID: teamsID)
        })
        
    }    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        InviteMembersView(teamsID: "1")
    }
}
