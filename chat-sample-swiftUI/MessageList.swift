import SwiftUI
import Amplify

struct MessageList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var input = ""
    
    var body: some View {
        VStack {
            List {
                ForEach(modelData.messages, id: \.id) { message in
                    MessageRow(message: message.text)
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
            .task {
                await performOnAppear()
                await subscribeMessages()
            }
            
            HStack {
                TextField("Aa", text: $input)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button {
                    Task { await sendMessage() }
                } label: {
                    Image(systemName: "arrow.up.circle.fill")
                }
            }
            .padding()
        }
    }
    
    func sendMessage() async {
        do {
            let newMessage = Message(text: input)
            let result = try await Amplify.API.mutate(request: .create(newMessage))
            
            switch result {
            case .success(let message):
                modelData.messages.append(newMessage)
                print("Success create new message: [\(message)].")
            case .failure(let error):
                print("Failer: \(error.errorDescription)")
            }
        } catch {
            print("Could not query DataStore: \(error)")
        }
    }
    
    func performOnAppear() async {
        do {
            let result = try await Amplify.API.query(request: .list(Message.self, where: nil))
            switch result {
            case .success(let results):
                modelData.messages = Array(results)
                print("Success: get all message")
            case .failure(let error):
                print("Failer: \(error.errorDescription)")
            }
        } catch {
            print("Could not query DataStore: \(error)")
        }
    }
    
    func subscribeMessages() async {
        do {
            let mutationEvents = Amplify.DataStore.observe(Message.self)
            for try await mutationEvent in mutationEvents {
                print("Subscription got this value: \(mutationEvent)")
                do {
                    let message = try mutationEvent.decodeModel(as: Message.self)
                    
                    switch mutationEvent.mutationType {
                    case "create":
                        print("Created: \(message)")
                    case "update":
                        print("Uppdated: \(message)")
                    case "delete":
                        print("Delete: \(message)")
                    default:
                        break
                    }
                } catch {
                    print("Model could not be decoded: \(error)")
                }
            }
        } catch {
            print("Unable to be observe mutation events")
        }
    }
}

struct MessageList_Previews: PreviewProvider {
    static var previews: some View {
        MessageList()
            .environmentObject(ModelData())
    }
}
