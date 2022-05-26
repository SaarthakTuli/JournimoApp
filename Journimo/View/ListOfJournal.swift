//
//  ListOfJournal.swift
//  Journimo
//
//  Created by Saarthak Tuli on 24/05/22.
//

import SwiftUI

struct ListOfJournal: View {
    
    @Environment(\.presentationMode) var present
    @EnvironmentObject var dataVM: DatabaseViewModel
    
    var body: some View {
            
        VStack {
            
            // MARK: Header
            HStack {
                
                Button {
                    present.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .padding(.leading)
                        .foregroundColor(.black)
                }
                
                Spacer()

                Text("Your Diary")
                    .font(.title)
                    .bold()
                    .padding(.leading, -15)
                
                Spacer()
            }
            
            List {
                ForEach(0..<dataVM.journalList.count, id: \.self) { index in
                    
                    VStack(alignment: .leading) {
                        
                        HStack(spacing: 0) {
                            Text("\(dataVM.journalList[index].date.components(separatedBy: ",")[0]), ")
                                .fontWeight(.semibold)
                                .font(.subheadline)
                            
                            Text("\(dataVM.journalList[index].date.components(separatedBy: ",")[1]), ")
                                .fontWeight(.semibold)
                                .font(.subheadline)
                            
                            Text("\(dataVM.journalList[index].date.components(separatedBy: ",")[2])")
                                .fontWeight(.semibold)
                                .font(.subheadline)
                        }
                        
                        Text("\(dataVM.journalList[index].title)")
                            .font(.title2)
                            .bold()
                            .lineLimit(1)
                        
                        HStack {
                            starCounter(starNum: dataVM.journalList[index].rating)
                            
                            Spacer()
                            
                            // MARK: Time fo entry...
                            Text("\(dataVM.journalList[index].date.components(separatedBy: ",")[3])")
                                .italic()
                            
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear() {
            dataVM.fetchJournal()
            
            print(dataVM.journalList[0].date.components(separatedBy: ","))
        }
        .navigationBarHidden(true)
    }
}

struct ListOfJournal_Previews: PreviewProvider {
    
    static let dataVM : DatabaseViewModel = {
        let dataVM = DatabaseViewModel()
        dataVM.journalList = journalPreviewList
        return dataVM
    }()
    
    static var previews: some View {
        ListOfJournal()
            .environmentObject(dataVM)
    }
}
