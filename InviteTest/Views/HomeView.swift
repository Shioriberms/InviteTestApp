//
//  ContentView.swift
//  InviteTest
//
//  Created by user210003 on 11/27/21.
//

import SwiftUI

struct HomeView: View {
    init()
    {
        Theme.navigationBarColors(background: .black, titleColor: .white)
    }
    
    //only for choosing random mock data
    @State var randomUser = Int.random(in: 1..<5)
//    @State var randomUser = 4
    var body: some View {
        NavigationView
        {
            NavigationLink(destination: InviteMembersView(teamsID : String(randomUser))) {
                Text("Invite")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Home")
            }
            .padding(.all)
            .buttonStyle(Theme.ButtonFormat())
            .simultaneousGesture(TapGesture().onEnded({randomUser = Int.random(in: 1..<5) }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
