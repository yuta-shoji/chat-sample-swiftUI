// swiftlint:disable all
import Amplify
import Foundation

extension Message {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case text
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let message = Message.keys
    
    model.authRules = [
      rule(allow: .public, operations: [.create, .update, .delete, .read])
    ]
    
    model.pluralName = "Messages"
    
    model.attributes(
      .primaryKey(fields: [message.id])
    )
    
    model.fields(
      .field(message.id, is: .required, ofType: .string),
      .field(message.text, is: .required, ofType: .string),
      .field(message.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(message.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension Message: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}