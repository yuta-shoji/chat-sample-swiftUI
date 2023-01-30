import Foundation
import Amplify

final class ModelData: ObservableObject {
    @Published var messages: [Message] = []
}
