import SwiftUI
import Combine
import MapKit

private class LoginData {
    var userName = ""
    var password = ""
}

private struct loginButton: View {
    var body: some View {
        Text("LOGIN")
            .font(.headline)
            .foregroundColor(Color.white)
            .padding()
            .frame(width: 100, height: 50)
            .background(Color.green)
            .cornerRadius(5)

    }
}

struct LoginView: View {
    @State var userName = ""
    @State var password = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("userName", text: $userName)
                SecureField("password", text: $password)

                Button(action: { print("login button tapped") }) {
                    loginButton()
                }
                NavigationLink(destination: LoginView()) {
                    Text("Register")
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .padding()
                        .frame(width: 100, height: 50)
                        .background(Color.green)
                        .cornerRadius(5)
                }
            }
        }

    }
}



