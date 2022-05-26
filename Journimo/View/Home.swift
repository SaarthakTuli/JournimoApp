//
//  Home.swift
//  Journimo
//
//  Created by Saarthak Tuli on 22/05/22.
//

import SwiftUI

var weeklyDay: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
var weeklyScore: [Int] = [1, 1, 1, 0, 0, 1, 0]

struct Home: View {
    
    @State var starRating: Double = 3.5
    @State var count = 0
    @State var countFinish = false
    
    @State var showMenu = false
    
    var body: some View {
        ZStack {
            Color("second").ignoresSafeArea()
            
            VStack {
                
                // MARK: Header Bar
                HStack {
                    Button {
                        withAnimation(.easeIn) { showMenu.toggle() }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .resizable()
                            .frame(width: 30, height: 20)
                            .foregroundColor(Color.white)
                    }

                    
                    Text("Welcome Back Home")
                        .bold()
                        .font(.title2)
                        .foregroundColor(Color.white)
                    
                    Spacer()
                    
                    NavigationLink {
                        NewJournalForm()
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 17, height: 17)
                    }

                    
                    NavigationLink {
                        ProfilePicture()
                    } label: {
                        Image(systemName: "person.fill")
                            .resizable()
                            .background(Color.black)
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                            .foregroundColor(Color.white)
                    }

                        
                       
                }
                .padding(.horizontal)
                
                Divider()
                
                //Spacer()
                
                // MARK: Last updated page
                
                VStack(alignment: .leading) {
                    Text("Latest Jounals: ")
                        .foregroundColor(Color.white)
                        .font(.title)
                        .bold()
                        .padding(.horizontal)
                    HStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(1...3, id: \.self) { _ in
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 40)
                                            .fill(Color("first"))
                                            .shadow(color: Color.white, radius: 3)
                                            
                                       
                                        
                                        // MARK: Details
                                        VStack(alignment: .leading) {
                                            
                                            Text(Date().formatted(.dateTime.month().day().year().weekday()))
                                                .bold()
                                                .padding([.horizontal, .top])
                                            
                                            Text("My first Balley Recital that went horribly yet also very fun")
                                                .bold()
                                                .font(.title2)
                                                .lineLimit(1)
                                                .padding(.horizontal)
                                                .padding(.vertical, 3)
                                                
                                            
                                            Text("Her is the first day that is ever recvorded int his journal. It does not have to be particullary funny or even amusing at all, It just has to exist as a record keep yet it is just to check if the smoothness and the working of the ui is acvcurate and as i have planned it top be")
                                                .padding(.horizontal)
                                                .lineLimit(3)
                                                
                                            
                                            Spacer()
                                      
                                            
                                            // MARK: Day rating
                                            HStack() {
                                               // MARK: Star Rating
                                                HStack {
                                                    ForEach(1...Int(floor(starRating)), id: \.self) { num in
                                                        Image(systemName: "star.fill")
                                                            .foregroundColor(Color(red: 1, green: 215/255, blue: 0, opacity: 100))
                                                    }
                                                    
                                                    if (ceil(starRating) != starRating) {
                                                        Image(systemName: "star.leadinghalf.filled")
                                                            .foregroundColor(Color(red: 1, green: 215/255, blue: 0, opacity: 100))
                                                    }
                                                    
                                                    
                                                    
                                                    ForEach(1...Int(5 - ceil(starRating)), id: \.self) { num in
                                                        Image(systemName: "star")
                                                            .foregroundColor(.black)
                                                    }
                                                }
                                                
                                                Spacer()
                                                
                                                // MARK: Emoji Rating
                                                Text("🥹")
                                                    .font(.title)
                                                
                                            }
                                            .padding(.horizontal)
                                            
                                            Spacer()
                                            
                                            
                                        }
                                    }
                                    .frame(width: UIScreen.main.bounds.width - 10, height: 200)
                                    .padding([.bottom, .horizontal], 5)
                                    
                                }
                            }
                        }
                    }
                }
                
                
                // MARK: WEEKLY DETAILS
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color.white)
                        .shadow(color: Color("first"), radius: 5)
                    
                    VStack {
                        
                        // MARK: Completion Circle
                        ZStack {
                            
                            Circle()
                                .stroke(Color("background"), style: StrokeStyle(lineWidth: 10, lineCap: .round , lineJoin: .round))
                                .rotationEffect(Angle(degrees: -90))
                                .frame(width: 130, height: 130)
                            
                            Circle()
                                .trim(from: 0, to: 0.5)
                                .stroke(Color("first"), style: StrokeStyle(lineWidth: 10, lineCap: .round , lineJoin: .round))
                                .rotationEffect(Angle(degrees: -90))
                                .frame(width: 130, height: 130)
                            
                            
                            Text("\(count)")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                
                        }
                        
                        // MARK: WEEKLY TICKS
                        HStack {
                            ForEach(0..<weeklyDay.count, id: \.self) { index in
                                VStack {
                                    Text("\(weeklyDay[index])")
                                        .font(.title3)
                                        .bold()
                                        .foregroundColor(.black)
                                    
                                    if (weeklyScore[index] == 0) {
                                        Circle()
                                            .fill(Color.black)
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
                }
                .frame(width: 300, height: 300)
                
                
                
              
                
                Spacer()
            }
            
            // Side view for app
            HStack {
                ZStack {
                    
                    Color.black
                        .opacity(showMenu == true ? 0.7 : 0)
                        .ignoresSafeArea()
                    
                    SideMenu()
                        .offset(x: showMenu == true ? -UIScreen.main.bounds.width/3.4 : -UIScreen.main.bounds.width)
                    
                    Spacer(minLength: 0)
                }
            }
            .onTapGesture {
                withAnimation(.easeIn) {showMenu.toggle()}
            }

        }
        .onAppear() {
            
            if (countFinish == false) {
                for item in weeklyScore {
                    if (item == 1) {
                        count += 1
                        countFinish = true
                    }
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    
    static let dataVM : DatabaseViewModel = {
        let dataVM = DatabaseViewModel()
        dataVM.journalList = journalPreviewList
        return dataVM
    }()
    
    static var previews: some View {
        NavigationView {
            Home()
                .navigationBarHidden(true)
                .environmentObject(dataVM)
        }
    }
}
