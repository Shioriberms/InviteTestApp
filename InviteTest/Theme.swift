//
//  Theme.swift
//  InviteTest
//
//  Created by user210003 on 11/27/21.
//

import Foundation
import UIKit
import SwiftUI

class Theme{
    static func navigationBarColors(background : UIColor?, titleColor: UIColor? = nil, tintColor : UIColor? = nil)
    {
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithOpaqueBackground()
        navigationAppearance.backgroundColor = background ?? .clear
        navigationAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .black]
        navigationAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .black]
        UINavigationBar.appearance().standardAppearance = navigationAppearance
        UINavigationBar.appearance().compactAppearance = navigationAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance
        UINavigationBar.appearance().tintColor = tintColor ?? titleColor ?? .black
        
       
    }
    
    struct ButtonFormat: ButtonStyle
    {
        func makeBody(configuration: Configuration) -> some View
        {
            configuration.label
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .background(Color.black)
                .foregroundColor(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .font(.system(size: 20))
        }
    }
    
    
}
