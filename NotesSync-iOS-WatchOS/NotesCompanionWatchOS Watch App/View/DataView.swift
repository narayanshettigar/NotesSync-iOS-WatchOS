//
//  DataView.swift
//  Notes Watch OS Watch App
//
//  Created by Narayan Shettigar on 18/06/23.
//

import SwiftUI

struct DataView: View {
    
    var note : Note
    var count : Int
    var index : Int
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 3){
            //  HEADER
            HeaderView()
            // CONTENT
            Spacer()
            
            ScrollView(.vertical){
                Text(note.text)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            Spacer()
            // FOOTER
            HStack(alignment: .center){
                Image(systemName: "gear")
                    .imageScale(.large)
                Spacer()
                Text("\(index) / \(count)")
                
                Spacer()
                
                NavigationLink(destination: CreditView()) {
                    Image(systemName: "info.circle")
                        .imageScale(.large)
                }.buttonStyle(PlainButtonStyle())
                

 
            }.foregroundColor(.secondary) // : Hstack
        } // : Vstack
    }
}

struct DataView_Previews: PreviewProvider {
    static var sampleData : Note = Note(id: UUID(), text: "Hello")
    static var previews: some View {
        DataView(note: sampleData , count: 5, index: 1)
    }
}
