import SwiftUI
import Combine
import MapKit
import Parse

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

                Button(action: { login(userName: self.userName, password: self.password) }) {
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


func login(userName: String, password: String) {
    PFUser.logInWithUsername(inBackground:"myname", password:"mypass") {
      (user: PFUser?, error: Error?) -> Void in
      if user != nil {
        // Do stuff after successful login.
        print("logged in")
      } else {
        // The login failed. Check error to see why.
        print(error.debugDescription)
      }
    }
}

