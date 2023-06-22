//
//  HeaderView.swift
//  Notes Watch OS Watch App
//
//  Created by Narayan Shettigar on 18/06/23.
//

import SwiftUI

struct HeaderView: View {
    var title : String = ""
    var body: some View {
        VStack{
            // Title
            if title != "" {
                Text(title.uppercased())
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.accentColor)
            }
            // Seperater
            HStack{
                Capsule()
                    .frame(height: 1)
                Image(systemName: "note.text")
                Capsule()
                    .frame(height: 1)
            }.foregroundColor(.accentColor) // : Hstack
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeaderView(title: "Credits")
            HeaderView()
        }
    }
}
