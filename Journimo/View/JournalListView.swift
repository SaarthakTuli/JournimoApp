//
//  JournalListView.swift
//  Journimo
//
//  Created by Saarthak Tuli on 23/05/22.
//

import SwiftUI

struct JournalListView: View {
    
    @EnvironmentObject var dataVM: DatabaseViewModel
    
    var body: some View {
        ZStack {
            
            Color("background").ignoresSafeArea()
  
            VStack {
               
                //ScrollView(.vertical, showsIndicators: true)
                List {
                    ForEach(0..<dataVM.journalList.count, id: \.self) { index in
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 40)
                                .fill(Color("first"))
                                .shadow(color: Color.white, radius: 3)
                            
                            VStack(alignment: .leading) {
                                Text("\(dataVM.journalList[index].date)")
                                    .bold()
                                    .padding([.horizontal, .top])
                                
                                Text(dataVM.journalList[index].title)
                                    .bold()
                                    .font(.title2)
                                    .lineLimit(1)
                                    .padding(.horizontal)
                                    .padding(.vertical, 3)
                                
                                Text(dataVM.journalList[index].body)
                                    .padding(.horizontal)
                                    .lineLimit(3)
                        
                        
                                Spacer()
                                
                                HStack {
                                    // MARK: Stars...
                                    starCounter(starNum: dataVM.journalList[index].rating)
                                    
                                    Spacer()
                                    
                                    // MARK: Emoji Rating
                                    Text(dataVM.journalList[index].emoji)
                                        .font(.title)
                                }
                                .padding(.horizontal)
                                
                                
                                Spacer()
                            }
                            
                        }
//                        .frame(width: UIScreen.main.bounds.width - 10, height: 200)
                        .padding([.bottom, .horizontal], 5)
                    }
                    .onDelete(perform: dataVM.deleteJournal)

                }
            }
            
            
        }
        .onAppear() {
            dataVM.fetchJournal()
        }
    }
}

struct JournalListView_Previews: PreviewProvider {
    
    static let dataVM : DatabaseViewModel = {
        let dataVM = DatabaseViewModel()
        dataVM.journalList = journalPreviewList
        return dataVM
    }()
    
    static var previews: some View {
        JournalListView()
            .environmentObject(dataVM)
    }
}

struct starCounter: View {
    
    var starNum: Double
    
    var body: some View {
        HStack {
            ForEach(0..<Int(floor(starNum)), id: \.self) { _ in
                Image(systemName: "star.fill")
                    .foregroundColor(Color(red: 1, green: 215/255, blue: 0, opacity: 100))
            }
            
            if ceil(starNum) != starNum {
                Image(systemName: "star.leadinghalf.fill")
                    .foregroundColor(Color(red: 1, green: 215/255, blue: 0, opacity: 100))
            }
            
            ForEach(0..<Int(5 - ceil(starNum)), id: \.self) { _ in
                Image(systemName: "star")
                    .foregroundColor(Color(red: 1, green: 215/255, blue: 0, opacity: 100))
            }
            
                
        }
    }
}

