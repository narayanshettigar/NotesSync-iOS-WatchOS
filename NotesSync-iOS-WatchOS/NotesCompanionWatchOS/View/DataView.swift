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
                    .padding(.leading,20)
                Spacer()
                Text("\(index) / \(count)")
                
                Spacer()
                
                NavigationLink(destination: CreditView()) {
                    Image(systemName: "info.circle")
                        .imageScale(.large)
                        .padding(.trailing,20)
                }
                .buttonStyle(PlainButtonStyle())
                
                

 
            }// : Hstack
            .foregroundColor(.secondary)
            .padding(.bottom,120)
            
        } // : Vstack
    }
}

struct DataView_Previews: PreviewProvider {
    static var sampleData : Note = Note(id: UUID(), text: "Hello")
    static var previews: some View {
        DataView(note: sampleData , count: 5, index: 1)
    }
}
