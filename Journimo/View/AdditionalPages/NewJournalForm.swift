//
//  NewJournalForm.swift
//  Journimo
//
//  Created by Saarthak Tuli on 23/05/22.
//

import SwiftUI
import FirebaseDatabaseSwift

struct NewJournalForm: View {
    
    @EnvironmentObject var dataVM: DatabaseViewModel
    @Environment(\.presentationMode) var present
    
    @State var date: Date = Date()
    @State var title: String = ""
    @State var detail: String = ""
    @State var stars: Double = 2.5
    @State var emoji: String = ""
    
    @State var journal: Model?
    
    @AppStorage("total_journals") var total_Journals = 0
    
    var body: some View {
        ZStack {
            Color("background").ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Button {
                        present.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding(.leading)
                    }

                    
                    Spacer()
                    
                    Text("New Journal")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.black)
                        .padding(.leading, -20)
                    
                    Spacer()
                }
                
                Divider()
                
                
                VStack {
                    ScrollView(.vertical, showsIndicators: true) {
                        
                        // MARK: Date.....
                        DatePicker("Date of Event: ", selection: $date)
                            .foregroundColor(.black)
                            .padding()
                            .font(.title3)
                            .background(Color.white)
                            .shadow(color: Color("second"), radius: 10)
                            .padding(.vertical)
                            .cornerRadius(40)
                        
                        
                        // MARK: Title....
                        VStack(alignment: .leading) {
                            Text("Title")
                                .foregroundColor(.black)
                                .font(.title2)
                                .bold()
                                .underline()
                                .padding(.bottom)
                            
                            TextField("Title", text: $title)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: Color("second"), radius: 10)
                       
                        // MARK: Body.....
                        VStack(alignment: .leading) {
                            Text("Body")
                                .foregroundColor(.black)
                                .font(.title2)
                                .bold()
                                .underline()
                            
                            TextEditor(text: $detail)
                                .frame(height: 400)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: Color("second"), radius: 10)
                        .padding(.vertical)
                        
                        
                        // MARK: Rating...
                        VStack(alignment: .leading) {
                            Text("Star Rating")
                                .foregroundColor(.black)
                                .font(.title2)
                                .bold()
                                .underline()
                            
                            Stepper("\(stars.removeZerosFromEnd())") {
                                if stars > 0 && stars < 5 {
                                    stars += 0.5
                                }
                            } onDecrement: {
                                if stars > 0 && stars < 5 {
                                    stars -= 0.5
                                }
                            }
                            
                            // MARK: Star Rating
                             HStack {
                                 ForEach(0..<Int(floor(stars)), id: \.self) { num in
                                     Image(systemName: "star.fill")
                                         .foregroundColor(Color(red: 1, green: 215/255, blue: 0, opacity: 100))
                                 }
                                 
                                 if (ceil(stars) != stars) {
                                     Image(systemName: "star.leadinghalf.filled")
                                         .foregroundColor(Color(red: 1, green: 215/255, blue: 0, opacity: 100))
                                 }
                                 
                                 
                                 
                                 ForEach(0..<Int(5 - ceil(stars)), id: \.self) { num in
                                     Image(systemName: "star")
                                         .foregroundColor(.black)
                                 }
                             }

                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: Color("second"), radius: 10)
                        .padding(.vertical)
                        
                        
                        // MARK: Emoji..
                        VStack(alignment: .leading) {
                            Text("Emoji")
                                .foregroundColor(.black)
                                .font(.title2)
                                .bold()
                                .underline()
                                .padding(.bottom)
                            
                            TextField("Emoji", text: $emoji)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: Color("second"), radius: 10)
                    }
                }
                
                Divider()
                
                Button {
                    
                    journal = Model(date: "\(date.formatted(.dateTime.weekday().day().month().year().hour().minute()))", title: title, body: detail, rating: stars, emoji: emoji)
                    
                    dataVM.writeJournal(journal: journal!)
                    
                    total_Journals += 1
                    
                    present.wrappedValue.dismiss()
                    print(total_Journals)
                    
                } label: {
                    PrimaryButton(title: "Save")
                }
                .padding(.vertical)

                
            }
        }
        .navigationBarHidden(true)
        .preferredColorScheme(.light)
        .onAppear() {
            dataVM.fetchJournal()
        }
    }
}

struct NewJournalForm_Previews: PreviewProvider {
    static var previews: some View {
        NewJournalForm()
            .preferredColorScheme(.dark)
    }
}


