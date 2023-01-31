import SwiftUI
import Amplify

struct ContentView: View {
    var body: some View {
        MessageList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
