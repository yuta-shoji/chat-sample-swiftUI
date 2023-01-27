import SwiftUI
import Amplify
import AWSDataStorePlugin

@main
struct chat_sample_swiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    init() {
        Amplify.Logging.logLevel = .info
        configureAmplify()
    }
    
    func configureAmplify() {
        let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
        do {
            try Amplify.add(plugin: dataStorePlugin)
            try Amplify.configure()
            print("Initialized Amplify");
        } catch {
            // simplified error handling for the tutorial
            print("Could not initialize Amplify: \(error)")
        }
    }
}
