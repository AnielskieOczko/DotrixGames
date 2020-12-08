import SwiftUI
import Combine
import MapKit
import Parse
import FBSDKLoginKit

struct LoginView: View {
    
    @State var signUp = false
    @State var user = ""
    @State var pass = ""
    @State var rePass = ""
    
    var body: some View {
        
        ZStack {
                
                ZStack {
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                        Color("Color")
                        .clipShape(CShape())
                        
                        Path{path in
                            path.addArc(center: CGPoint(x: UIScreen.main.bounds.width - 120, y: UIScreen.main.bounds.height - 50), radius: 40, startAngle: .zero, endAngle: .init(degrees: 180), clockwise: true)
                        }
                        .fill(Color.white)
                        
                        // buttons
                        Button(action: {
                            withAnimation(.easeIn) {
                                self.signUp = false
                            }
                        }) {
                            Image(systemName: signUp ? "xmark": "person.fill")
                                .font(Font.system(size: 25,weight: .bold))
                                .foregroundColor(Color("Color"))
                        }
                        .offset(x: -110, y: -50)
                        .disabled(signUp ? false: true)
                    
                        Button(action: {
                            withAnimation(.easeOut) {
                                self.signUp = true
                            }
                        }) {
                            Image(systemName: signUp ? "person.badge.plus.fill": "xmark")
                                .font(Font.system(size: signUp ? 26: 25,weight: .bold))
                                .foregroundColor(Color.white)
                        }
                        .offset(x: -30, y: -30)
                        .disabled(signUp ? true: false)
                    }
                    
                    // login view
                    VStack(alignment: .leading, spacing: 25) {
                        Text("Login")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(Color.white)
                        
                        Text("UserName")
                            .foregroundColor(Color.white)
                            .padding(.top, 10)
                        
                        VStack {
                            TextField("UserName", text: $user)
                            
                            Divider()
                                .background(Color.white.opacity(0.5))
                        }
                        
                        Text("Password")
                            .foregroundColor(Color.white)
                            .padding(.top, 10)
                        
                        VStack {
                            SecureField("Password", text: $pass)
                            
                            Divider()
                                .background(Color.white.opacity(0.5))
                            
                            HStack {
                                Spacer()
                                //Login button
                                Button(action: {
                                    login(userName: self.user, password: self.pass)
                                }) {
                                    Text("Login")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("Color"))
                                        .padding(.vertical)
                                        .padding(.horizontal, 45)
                                        .background(Color.white)
                                        .clipShape(Capsule())
                                }
                                Spacer()
                                
                                
                                loginViewController()
                                //.padding(.vertical)
                                //.padding(.horizontal, 450)
                                        //.offset(x: -140, y: -100)
                                        //.disabled(signUp ? true: false)
                            
                            }
                            .padding(.top)
                        }
                        Spacer(minLength: 0)
                    }
                    .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 35)
                    .padding()
                }
                // moving view up
                // fix for iphone 8
                .offset(y: signUp ? -UIScreen.main.bounds.height +
                    (UIScreen.main.bounds.height < 750 ? 100: 130) : 0)
                    .zIndex(1) // manages views to do not overlap
                
                // SignUp view
                VStack(alignment: .leading, spacing: 25) {
                    Text("Sign Up")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(Color("Color"))
                    
                    Text("UserName")
                        .foregroundColor(Color("Color"))
                        .padding(.top, 10)
                    
                    VStack {
                        TextField("UserName", text: $user)
                        
                        Divider()
                            .background(Color("Color").opacity(0.5))
                    }
                    
                    Text("Password")
                        .foregroundColor(Color("Color"))
                        .padding(.top, 10)
                    
                    VStack {
                        SecureField("Password", text: $pass)
                        
                        Divider()
                            .background(Color("Color").opacity(0.5))
                    }
                    
                    Text("Re-Enter")
                        .foregroundColor(Color("Color"))
                        .padding(.top, 10)
                    
                    // here you have to add separate txt field Binding
                    VStack {
                        SecureField("Re-Enter", text: $pass)
                        
                        Divider()
                            .background(Color("Color").opacity(0.5))
                    }
                    HStack {
                        Spacer()
                        //Sign Up button
                        Button(action: {}) {
                            Text("Sign Up")
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .padding(.vertical)
                                .padding(.horizontal, 45)
                                .background(Color("Color"))
                                .clipShape(Capsule())
                        }
                        Spacer()
                    }
                    .padding(.top)
                    Spacer(minLength: 0)
                }
                .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 120)
                .padding()
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
            // change user interface style
            .preferredColorScheme(signUp ? .light: .dark)
        }
    }


struct CShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path{path in
            
            // bottom shape
            path.move(to: CGPoint(x: rect.width, y: rect.height - 50))
            path.addLine(to:CGPoint(x: rect.width, y: 0))
            path.addLine(to:CGPoint(x: 0, y: 0))
            path.addLine(to:CGPoint(x: 0, y: rect.height - 50))
            
            // add curve
            path.addArc(center: CGPoint(x: rect.width - 40, y: rect.height - 50), radius: 40, startAngle: .zero, endAngle: . init(degrees: 180), clockwise: false)
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
/*
struct ContentView: View {
    @ObservedObject var fbmanager = UserLoginManager()
    var body: some View {
        Button(action: {
            self.fbmanager.facebookLogin()
        }) {
            Text("Continue with Facebook")
        }
    }
}
*/




/*
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

*/


