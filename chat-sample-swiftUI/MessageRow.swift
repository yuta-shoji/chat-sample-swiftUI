import SwiftUI

struct MessageRow: View {
    var message: String
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack {
                Text(message)
                    .padding(8)
                    .background(.red)
                    .cornerRadius(6)
                    .foregroundColor(.white)
            }
        }
    }
}

struct MessageRow_Previews: PreviewProvider {
    static var previews: some View {
        MessageRow(message: "new message")
    }
}
