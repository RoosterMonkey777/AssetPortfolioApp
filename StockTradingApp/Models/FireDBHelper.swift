//
//  FireDBHelper.swift
//  StockTradingApp
//
//  Created by Zahaak Khan on 2022-12-11.
//

//import Foundation
//import FirebaseFirestore
//
//class FireDBHelper : ObservableObject{
//    
//    @Published var bookList = [Book]()
//    
//    private let store : Firestore
//    private let COLLECTION_BOOKS : String = "Books"
//    private let COLLECTION_LIBRARY : String = "Library"
//    
//    //singleton design pattern
//    private static var shared : FireDBHelper?
//    
//    init(database : Firestore){
//        self.store = database
//    }
//    
//    static func getInstance() -> FireDBHelper{
//        if (shared == nil){
//            shared = FireDBHelper(database: Firestore.firestore())
//        }
//        
//        return shared!
//    }
//    
//    func insertBook(newBook : Book){
//        let loggedInUser : String = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? "NA"
//        
//        do{
//            try self.store
//                .collection(COLLECTION_LIBRARY)
//                .document(loggedInUser)
//                .collection(COLLECTION_BOOKS)
//                .addDocument(from: newBook)
//
//        }catch let error as NSError{
//            print(#function, "Error while inserting document on firestore \(error)")
//        }
//    }
//    
//    func getAllBooks(){
//        
//        self.bookList.removeAll()
//        
//        let loggedInUser : String = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? "NA"
//        
//        self.store
//            .collection(COLLECTION_LIBRARY)
//            .document(loggedInUser)
//            .collection(COLLECTION_BOOKS)
////            .whereField("bIsFiction", isEqualTo: true)
//            .order(by: "bTitle", descending: true)
//            .addSnapshotListener( { (querySnapshot, error)  in
//                
//                guard let snapshot = querySnapshot else{
//                    print(#function, "Error while retrieving records \(error)")
//                    return
//                }
//                
//                snapshot.documentChanges.forEach{ (docChange) in
//                    
//                    do{
//                        
//                        var book = Book()
//                        book = try docChange.document.data(as: Book.self)
//                        
//                        let docID = docChange.document.documentID
//                        book.id = docID
//                        
//                        let matchedIndex = self.bookList.firstIndex(where: { ($0.id?.elementsEqual(docID))! })
//                        
//                        if docChange.type == .added{
//                            self.bookList.append(book)
//                            print(#function, "Document ADDED : \(book)")
//                        }
//                        
//                        if docChange.type == .modified{
//                            //change or replace current object in bookList with updated values
//                            
//                            if(matchedIndex != nil){
//                                self.bookList[matchedIndex!] = book
//                            }
//                            
//                        }
//
//                        if docChange.type == .removed{
//                            if(matchedIndex != nil){
//                                self.bookList.remove(at: matchedIndex!)
//                            }
//                        }
//                        
//                    }catch let err as NSError{
//                        print(#function, "unable to identify document change \(err)")
//                    }
//                    
//                }
//                
//            })
//    }
//    
//    func updateBook(bookToUpdate : Book){
//        
//        let loggedInUser : String = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? "NA"
//        
////        self.store
////            .collection(COLLECTION_NAME)
////            .document(bookToUpdate.id!)
////            .set(bookToUpdate)
////
//        
//        self.store
//            .collection(COLLECTION_LIBRARY)
//            .document(loggedInUser)
//            .collection(COLLECTION_BOOKS)
//            .document(bookToUpdate.id!)
//            .updateData(["bTitle" : bookToUpdate.bTitle,
//                         "bAuthor" : bookToUpdate.bAuthor,
//                         "bIsFiction" : bookToUpdate.bIsFiction]){error in
//                
//                if let err = error{
//                    print(#function, "Error while updating document \(err)")
//                }else{
//                    print(#function, "Book \(bookToUpdate.bTitle) updated successfully")
//                }
//                
//            }
//    }
//    
//    func deleteBook(bookToDelete : Book){
//        
//        let loggedInUser : String = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? "NA"
//        
//        self.store
//            .collection(COLLECTION_LIBRARY)
//            .document(loggedInUser)
//            .collection(COLLECTION_BOOKS)
//            .document(bookToDelete.id!)
//            .delete{error in
//                
//                if let err = error{
//                    print(#function, "Error while deleting document \(err)")
//                }else{
//                    print(#function, "Book \(bookToDelete.bTitle) deleted successfully")
//                }
//                
//            }
//    }
//    
//}
//
