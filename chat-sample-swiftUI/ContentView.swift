import SwiftUI

struct Message {
    let id = UUID()
    let text: String
}

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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
