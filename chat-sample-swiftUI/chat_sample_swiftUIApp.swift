import SwiftUI
import Amplify
import AWSDataStorePlugin
import AWSAPIPlugin

@main
struct chat_sample_swiftUIApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
    
    init() {
        Amplify.Logging.logLevel = .info
        configureAmplify()
    }
    
    func configureAmplify() {
        let apiPlugin = AWSAPIPlugin(modelRegistration: AmplifyModels())
        let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
        do {
            try Amplify.add(plugin: apiPlugin)
            try Amplify.add(plugin: dataStorePlugin)
            try Amplify.configure()
            print("Initialized Amplify");
        } catch {
            // simplified error handling for the tutorial
            print("Could not initialize Amplify: \(error)")
        }
    }
}
