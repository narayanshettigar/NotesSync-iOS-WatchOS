
import SwiftUI

struct ContentView: View {
    // MARK :- Property
    @EnvironmentObject var phoneConnectivityManager: PhoneConnectivityManager
    
    @State private var notes: [Note] = [Note]()

    @State private var text: String = ""


//    func delete(offsets: IndexSet) {
//        withAnimation {
//            notes.remove(atOffsets: offsets)
//        }
//    }
    
    func delete(offsets: IndexSet) {
        withAnimation {
            let deletedNotes = offsets.map { notes[$0] }
            deletedNotes.forEach { deletedNote in
                if let index = notes.firstIndex(of: deletedNote) {
                    notes.remove(at: index)
                }
                phoneConnectivityManager.sendNoteToWatch(deletedNote)
            }
        }
    }

    // MARK :- Body
    var body: some View {
        NavigationView {
            VStack {
                let name = "Notes"
                HStack{
                    Text(name)
                        .padding(10)
                        .foregroundColor(.accentColor)
                        .font(.system(size: 45))
                    Spacer()
                }
                
                HStack(alignment: .center, spacing: 6) {
                    TextField("Add New Note", text: $text)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    Button {
                        // Action
                        guard text.isEmpty == false else { return }

                        let note = Note(id: UUID(), text: text)
                        notes.append(note)
                        
                        phoneConnectivityManager.sendNoteToWatch(note)

                        text = ""
                        
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 42, weight: .semibold))
                    }
                    .fixedSize()
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(.accentColor)
                }

                Spacer()


                
                if notes.count >= 1 {
                    List {
                        ForEach(0..<notes.count, id: \.self) { i in
                            NavigationLink(destination: DataView(note: notes[i], count: notes.count, index: i+1)) {
                                HStack {
                                    Capsule()
                                        .frame(width: 4)
                                        .foregroundColor(.accentColor)
                                    Text(notes[i].text)
                                }
                            }
                            .padding(.vertical, 8)
                        }
                        .onDelete(perform: delete)
                    }
                } else {
                    Spacer()
                    Image(systemName: "note.text")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .opacity(0.25)
                        .padding(70)
                        .padding(.bottom,120)
                    Spacer()
                }
                
            }
            //.navigationBarTitle("Notes") // Add the navigation bar title here
            
        }
        .onAppear {
            // Activate the WCSession when the ContentView appears
            phoneConnectivityManager.activateWCSession()
        }.onReceive(phoneConnectivityManager.$connectivityNotes){
            note in
            updateNotes(with: note)
        }
    }
    

    func updateNotes(with note: Note) {
        DispatchQueue.main.async {
            if let index = notes.firstIndex(where: { $0.id == note.id }) {
                notes.remove(at: index)
            } else if !note.text.isEmpty {
                notes.append(note)
            }
        }
    }
}



// MARK :- Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


