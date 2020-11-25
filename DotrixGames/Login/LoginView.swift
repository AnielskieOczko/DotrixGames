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

                Button(action: { login(username: self.userName, password: self.password, email: "") }) {
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



func login(username: String, password: String, email: String) {
    let user = PFUser()
  user.username = username
  user.password = password
  user.email = email
  // other fields can be set just like with PFObject
  user["phone"] = "415-392-0202"

  user.signUpInBackground {
    (succeeded: Bool, error: Error?) -> Void in
    if let error = error {
      let errorString = error.localizedDescription
      // Show the errorString somewhere and let the user try again.
    } else {
      // Hooray! Let them use the app now.
    }
  }
}
