//
//  ProfilePicture.swift
//  Journimo
//
//  Created by Saarthak Tuli on 23/05/22.
//

import SwiftUI
import Firebase
import GoogleSignIn


struct ProfilePicture: View {
    
    @AppStorage("log_status") var log_Status = false
    
    var body: some View {
        ZStack {
            Color("background").ignoresSafeArea()
            
            VStack {
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .background(Color.white)
                    .clipShape(Circle())
                    .padding(.top)
                
                
                Text("Welcome Home")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.black)
                
                Text("Saarthak Tuli")
                    .foregroundColor(.black)
                    .font(.title)
                    .fontWeight(.semibold)
                
                Divider()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color("first"))
                        .frame(width: UIScreen.main.bounds.width - 10, height: 130)
                    
                    HStack {
                        ForEach(0..<weeklyDay.count, id: \.self) { index in
                            VStack {
                                Text("\(weeklyDay[index])")
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(.black)
                                
                                if (weeklyScore[index] == 0) {
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 20, height: 20)
                                }
                                else {
                                    Image(systemName: "checkmark.seal.fill")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(Color.green)
                                      
                                   
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 4)
                    .padding(.bottom)
                }
                
                
//                Circle()
//                    //.trim(from: 0, to: CGFloat(0.8))
//                    .stroke(LinearGradient(gradient: Gradient(colors: [Color("first"), Color("second")]), startPoint: .trailing, endPoint: .leading), style:
//                        StrokeStyle(lineWidth: 46,
//                                    lineCap: .round))
                
                Button {
                    googleLogOut()
                } label: {
                    PrimaryButton(title: "LogOut")
                }

                
                
                Spacer()
            }
        }
    }
    
    func googleLogOut() {
        GIDSignIn.sharedInstance.signOut()
        try! Auth.auth().signOut()
        
        withAnimation {
            log_Status = false
        }
        
        print("Successfully logged out...")
    }
}

struct ProfilePicture_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePicture()
    }
}
