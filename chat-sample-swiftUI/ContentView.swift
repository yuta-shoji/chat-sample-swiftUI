import SwiftUI
import Amplify

struct ContentView: View {
//    @EnvironmentObject var modelData: ModelData
//    var messages: [Message] = []
    
    //    func getMessages() async {
    //        print("++++++++++++++++++++++++++++")
    //        do {
    //            modelData.messages = try await Amplify.DataStore.query(Message.self)
    //            print("==========================================================")
    //            print(modelData.messages)
    //        } catch {
    //            print("Could not query DataStore: \(error)")
    //        }
    //    }
    
    var body: some View {
        List {
            Text("hoge")
//            ForEach(messages, id: \.id) { message in
//                Text(message.text)
//            }
        }
//        .task {
//            await performOnAppear()
//            await subscribeMessages()
//        }
    }
    
    func performOnAppear() async {
        let request = GraphQLRequest<Message>.list(Message.self, where: true as? QueryPredicate, limit: 100)
        
        do {
            //            let item = Message(text: "fizzbuzz")
            //            var result = try await Amplify.API.mutate(request: .create(item))
            //            print(result)
            let result = try await Amplify.API.query(request: request)
            switch result {
            case .success(let results):
                print("succes!!!!")
//                messages = Array(results)
//                for message in messages {
//                    print("=== message ===")
//                    print("Text: \(message.text)")
//                }
            case .failure(let error):
                print("failer\(error.errorDescription)")
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
                        print("Created:\(message)")
                    case "update":
                        print("Uppdated:\(message)")
                    case "delete":
                        print("Delete:\(message)")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .environmentObject(ModelData())
    }
}
