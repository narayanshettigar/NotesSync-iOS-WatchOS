import SwiftUI

struct ContentView: View {
    @EnvironmentObject var watchConnectivityManager: WatchConnectivityManager

    @State private var notes: [Note] = []

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
                watchConnectivityManager.sendNoteToPhone(deletedNote)
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .center, spacing: 6) {
                    TextField("Add New Note", text: $text)
                    Button {
                        guard text.isEmpty == false else { return }

                        let note = Note(id: UUID(), text: text)
                        notes.append(note)
                        watchConnectivityManager.sendNoteToPhone(note)
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
                        .padding(15)
                    Spacer()
                }
            }
            .navigationBarTitle("Notes")
            .onAppear {
                watchConnectivityManager.activateWCSession()
            }
            .onReceive(watchConnectivityManager.$connectivityNotes) { note in
                updateNotes(with: note)
            }
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
