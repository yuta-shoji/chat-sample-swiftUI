import SwiftUI
import Amplify

struct ContentView: View {
    var messages: [Message] = [
        Message(text: "aaaa"),
        Message(text: "bbbbb"),
        Message(text: "ccccc"),
    ]
    var messages2: [String] = ["aaaa", "bbbbbb", "ccccc"]
    var body: some View {
        List {
            ForEach(messages, id: \.id) { message in
                Text(message.text)
            }
        }
        .task {
            await performOnAppear()
        }
    }
    func performOnAppear() async {
        do {
            let messages = try await Amplify.DataStore.query(Message.self)
            for message in messages {
                print("=== message ===")
                print("Text: \(message.text)")
            }
        } catch {
            print("Could not query DataStore: \(error)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
