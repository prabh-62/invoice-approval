import Moya
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userAuth: UserAuth
    
    @State private var credentials = LoginCredentials(UserName: "", Password: "", Devicetoken: "iOS")
    @State private var buttonState = ButtonState(label: "Login", disabled: false)
    
    @State var errorDescription = ErrorDescription(showAlert: false, title: nil, description: nil)
    
    func login() {
        buttonState.disabled = true
        buttonState.label = "Logging in"
        
        provider.request(.login(credentials), completion: {
            result in
            buttonState.disabled = false
            buttonState.label = "Login"
            do {
                let data: LoginResponse = try mapTo(result)
                print(data.BellatrixToken)
                userAuth.accessToken = data.BellatrixToken
                
                let defaults = UserDefaults.standard
                defaults.set(userAuth.accessToken, forKey: "BellatrixToken")
                
            } catch {
                self.errorDescription = getErrorObject(error)
            }
        })
    }
    
    var body: some View {
        Group {
            VStack {
                HStack {
                    Image("login_banner")
                        .resizable()
                        .frame(height: 400, alignment: Alignment.trailing)
                        .aspectRatio(contentMode: .fit)
                    
                }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/ .all/*@END_MENU_TOKEN@*/)
                
                Spacer()
                
                VStack {
                    HStack {
                        TextField("Username", text: $credentials.UserName)
                    }
                    .textFieldStyle(FormFieldStyle())
                    .autocapitalization(.none)
                    .disabled(buttonState.disabled)
                    .padding(.bottom, 20)
                    
                    HStack {
                        SecureField("Password", text: $credentials.Password)
                    }.textFieldStyle(FormFieldStyle())
                        .disabled(buttonState.disabled)
                        .padding(.bottom, 20)
                    
                    Button(buttonState.label) {
                        self.login()
                    }
                    .disabled(buttonState.disabled)
                    .buttonStyle(ThemedButtonStyle(backgroundColor: Color.primaryColor))
                    .foregroundColor(Color.white)
                    .alert(isPresented: $errorDescription.showAlert) {
                        Alert(title: Text(errorDescription.title!), message: Text(errorDescription.description!), dismissButton: .default(Text("Dismiss")))
                    }
                }.padding(20)
                Spacer()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
