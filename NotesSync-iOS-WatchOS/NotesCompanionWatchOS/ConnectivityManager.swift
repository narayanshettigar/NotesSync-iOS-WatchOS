import Foundation
import WatchConnectivity

class PhoneConnectivityManager: NSObject, ObservableObject, WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        return
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        return
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        return
    }
      
    @Published var connectivityNotes: Note = Note(id: UUID(), text: "")
    
    override init() {
        super.init()
        activateWCSession()
    }

    func activateWCSession() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }

    func sendNoteToWatch(_ note: Note) {
        if WCSession.default.isReachable {
            let noteDict: [String: Any] = ["id": note.id.uuidString, "text": note.text]
            let message = ["note": noteDict]
            WCSession.default.sendMessage(message, replyHandler: nil) { error in
                print("Error sending message to Watch app: \(error.localizedDescription)")
            }
        } else {
            print("Watch app is not reachable")
        }
    }

    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        if let noteDict = message["note"] as? [String: Any],
            let idString = noteDict["id"] as? String,
            let text = noteDict["text"] as? String,
            let id = UUID(uuidString: idString) {
            let receivedNote = Note(id: id, text: text)
            DispatchQueue.main.async {
                self.connectivityNotes = receivedNote
            }
        }
    }

}

