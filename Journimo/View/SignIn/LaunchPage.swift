//
//  LaunchPage.swift
//  Journimo
//
//  Created by Saarthak Tuli on 22/05/22.
//

import SwiftUI

struct LaunchPage: View {
    
    @State private var show = false
    @State var showHome = false
    
    @State var showDocument = false
    
//    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//    @State var timeRemaining = 3
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Color.white.ignoresSafeArea()

                if show {
                    VStack(spacing: 15) {
                        Spacer()
                        
                        Text("Welcome Home")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color("second"))
                           
                        
                        Image("launch")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width)
                        
                        NavigationLink {
                            SignInView()
                        } label: {
                            PrimaryButton(title: "Login")
                        }

                        
                        Spacer()
                        
                        HStack(spacing: 2) {
                            Text("This is a safe space, ")
                                .foregroundColor(.black)
                            
                            Button {
                                showDocument.toggle()
                            } label: {
                                Text("read more")
                                    .foregroundColor(Color("second"))
                            }

                                
                        }
                    }
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 5)))
                    
                   
                }
                
    //            if showHome {
    //                Home()
    //                    .transition(AnyTransition.opacity.animation(.easeIn(duration: 2)))
    //            }
            }
            .onAppear() {
                show = true
            }
            .popover(isPresented: $showDocument) {
                DocumentView()
            }
            .navigationBarHidden(true)
    //        .onReceive(timer) { _ in
    //            if (timeRemaining > 0){
    //                timeRemaining -= 1
    //            }
    //
    //            else {
    //                show = false
    //                showHome = true
    //            }
    //        }
        }
    }
}

struct LaunchPage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LaunchPage()
        }
    }
}


struct PrimaryButton: View {
    
    var title: String
    
    var body: some View {
        
        Text(title)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width - 10, height: 70)
            .background(Color("second"))
            .cornerRadius(40)
        

    }
}
