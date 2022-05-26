//
//  DatabaseViewModel.swift
//  Journimo
//
//  Created by Saarthak Tuli on 23/05/22.
//

import SwiftUI
import Firebase


class DatabaseViewModel: ObservableObject {
    
    @Published var journalList: [Model] = []
    
    @AppStorage("total_journals") var total_Journals = 0
    
    
    init() {
        fetchJournal()
    }
    
    // MARK: Read data from the dataabase...
    func fetchJournal() {
        
        let db = Firestore.firestore()
        
        db.collection(Auth.auth().currentUser?.uid ?? " ").getDocuments { snapshot, error in
            
            if error == nil {
                guard let snapshot = snapshot else { return }
                
                self.journalList = snapshot.documents.compactMap({ (doc) -> Model? in
                    let id = doc.get("id") as? Int ?? 0
                    let date = doc.get("date") as? String ?? ""
                    let title = doc.get("title") as? String ?? ""
                    let body = doc.get("body") as? String ?? ""
                    let rating = doc.get("rating") as? Double ?? 0
                    let emoji = doc.get("emoji") as? String ?? ""
                    
                    
                    return Model(id: id, date: date, title: title, body: body, rating: rating, emoji: emoji)
                })

            }
        }
        print("Fetch Complete...")
    }
    
    
    // MARK: Write each journal to the database...
    func writeJournal(journal: Model) {
        
        let db = Firestore.firestore()
        
        db.collection(Auth.auth().currentUser?.uid ?? "").document("\(total_Journals)").setData(
            [
                "id" : total_Journals,
                "title" : "\(journal.title)",
                "body" : "\(journal.body)",
                "rating" : journal.rating,
                "date" : "\(journal.date)",
                "emoji" : journal.emoji
            ]) { (error) in
                 
                 if error != nil {
                     print("Error while adding data: \(String(describing: error?.localizedDescription)))")
                     return
                 }
                 
                 print("Successfully added data in database...")
             }
    }
    
    
    // MARK: Delete the journal entry....
    func deleteJournal(at offsets: IndexSet) {
        
        let db = Firestore.firestore()
        
        db.collection(Auth.auth().currentUser?.uid ?? " ").document("\(offsets)").delete() { error in
            
            if let error = error {
                print("Error while deleting: \(error.localizedDescription)")
            }
            
            else {
                self.journalList.remove(atOffsets: offsets)
                self.total_Journals -= 1
                
                print("SUCCESSFULLY DELETED")
                print("Total no. of journals are: \(self.total_Journals)")
            }
            
        }
    }
    
}
 
