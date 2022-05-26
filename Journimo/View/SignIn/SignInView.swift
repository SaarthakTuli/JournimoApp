//
//  SignInView.swift
//  Journimo
//
//  Created by Saarthak Tuli on 23/05/22.
//

import SwiftUI
import Firebase
import GoogleSignIn


struct SignInView: View {
    
    @State var isLoading = false
    
    @AppStorage("log_status") var log_Status = false
    
    var body: some View {
        
        if log_Status {
            Home()
                .navigationBarHidden(true)
        }
        else {
            ZStack {
                Color("background").ignoresSafeArea()
                
                VStack {
                    Text("Welcome to Journimo")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .padding()
                    
                    Text("This is a safe Space for you. You can share whatever you want and we shall keep it a secret")
                        .font(.title2)
                        .padding()
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button {
                        googleLogin()
                    } label: {
                        HStack {
                            Image("google")
                                .resizable()
                                .frame(width: 40, height: 40)
                            
                            Text("Sign In With Google")
                                .foregroundColor(.white)
                                .font(.system(size: 24))
                        }
                        .frame(width: UIScreen.main.bounds.width - 30, height: 70)
                        .background(Color("second"))
                        .cornerRadius(50)
                        
                    }

                    
                    
                    Spacer()
                        
                }
            }
            .overlay {
                ZStack {
                    if isLoading {
                        Color.black
                            .opacity(0.2)
                            .ignoresSafeArea()
                        
                        ProgressView()
                            .font(.title2)
                            .frame(width: 60, height: 60)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
    
    func googleLogin(){
        
        // Google Sign In...
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        isLoading=true
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: getRootViewController()) {[self] user, error in
            if let error = error {
                isLoading=false
                print(error.localizedDescription)
               return
             }

             guard
               let authentication = user?.authentication,
               let idToken = authentication.idToken
                else {
                    isLoading=false
                    return
                }

             let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                            accessToken: authentication.accessToken)
            
            // Firebase Auth...
            Auth.auth().signIn(with: credential) { result, error in
                isLoading=false
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                // Display Username
                
                guard let user = result?.user else{return}
                
                print(user.displayName ?? "Success!")
                
                // Updating user as logged In...
                withAnimation {
                    log_Status = true
                }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

