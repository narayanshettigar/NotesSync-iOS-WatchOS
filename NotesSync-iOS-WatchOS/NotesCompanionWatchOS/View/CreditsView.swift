//
//  Credit.swift
//  Notes Watch OS Watch App
//
//  Created by Narayan Shettigar on 18/06/23.
//

import SwiftUI

struct CreditView: View {
    
    // Property
    
    // Body
    var body: some View {
        VStack{
            // Profile Image
            Image("myProfile")
                .resizable()
                .cornerRadius(50)
                .scaledToFit()
                .scaleEffect()
            Spacer()
        
            // Header
            HeaderView(title: "Credits")
            // Content
            Text("Narayan Shettigar")
                .foregroundColor(.primary)
                .fontWeight(.bold)
            Text("Developer")
                .font(.footnote)
                .foregroundColor(.secondary)
                .fontWeight(.light)
        }

    } // : Vstack
}

struct Credit_Previews: PreviewProvider {
    static var previews: some View {
        CreditView()
    }
}
