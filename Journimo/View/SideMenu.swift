//
//  SideMenu.swift
//  Journimo
//
//  Created by Saarthak Tuli on 23/05/22.
//

import SwiftUI

struct SideMenu: View {
    
    @EnvironmentObject var dataVM: DatabaseViewModel
    
    var body: some View {
        VStack {
            
            Text("Saarthak Tuli")
                .font(.title2)
                .bold()
            
            Divider()
            
            NavigationLink {
                ListOfJournal()
                    .navigationBarHidden(true)
            } label: {
                HStack {
                    Image(systemName: "house.fill")
                    
                    Text("Journal View")
                        .bold()
                }
                .foregroundColor(.black)
            }

            
            Spacer()
            
        }
        .padding([.top, .trailing])
        .frame(width: UIScreen.main.bounds.width/2)
        .background(Color.white.ignoresSafeArea())
        .onAppear() {
            dataVM.fetchJournal()
        }
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu()
    }
}
