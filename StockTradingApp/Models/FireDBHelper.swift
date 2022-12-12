// Group# 12
// Zahaak Khan : 991625231
// Shareef Aldahhan : 991598634

// worked on by Zahaak

// helper for the firestore database, inlcuding the CRUD methods to add the db

import Foundation
import FirebaseFirestore

class FireDBHelper : ObservableObject{
    
    @Published var assetList = [AssetDBModel]()
    
    private let store : Firestore
    private let COLLECTION_ASSETS : String = "Assets"
    private let COLLECTION_LIBRARY : String = "Library"
    
    //singleton design pattern
    private static var shared : FireDBHelper?
    
    init(database : Firestore){
        self.store = database
    }
    
    static func getInstance() -> FireDBHelper{
        if (shared == nil){
            shared = FireDBHelper(database: Firestore.firestore())
        }
        
        return shared!
    }
    
    func insertAsset(newAsset : AssetDBModel){
        let loggedInUser : String = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? "NA"
        
        do{
            try self.store
                .collection(COLLECTION_LIBRARY)
                .document(loggedInUser)
                .collection(COLLECTION_ASSETS)
                .addDocument(from: newAsset)

        }catch let error as NSError{
            print(#function, "Error while inserting document on firestore \(error)")
        }
    }
    
    func getAllAssets(){
        
        self.assetList.removeAll()
        
        let loggedInUser : String = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? "NA"
        
        self.store
            .collection(COLLECTION_LIBRARY)
            .document(loggedInUser)
            .collection(COLLECTION_ASSETS)

            .order(by: "coinId", descending: true)
            .addSnapshotListener( { (querySnapshot, error)  in
                
                guard let snapshot = querySnapshot else{
                    print(#function, "Error while retrieving records \(error)")
                    return
                }
                
                snapshot.documentChanges.forEach{ (docChange) in
                    
                    do{
                        
                        var asset = AssetDBModel()
                        asset = try docChange.document.data(as: AssetDBModel.self)
                        
                        let docID = docChange.document.documentID
                        asset.id = docID
                        
                        let matchedIndex = self.assetList.firstIndex(where: { ($0.id?.elementsEqual(docID))! })
                        
                        if docChange.type == .added{
                            self.assetList.append(asset)
                            print(#function, "Document ADDED : \(asset)")
                        }
                        
                        if docChange.type == .modified{
                            //change or replace current object in bookList with updated values
                            
                            if(matchedIndex != nil){
                                self.assetList[matchedIndex!] = asset
                            }
                            
                        }

                        if docChange.type == .removed{
                            if(matchedIndex != nil){
                                self.assetList.remove(at: matchedIndex!)
                            }
                        }
                        
                    }catch let err as NSError{
                        print(#function, "unable to identify document change \(err)")
                    }
                    
                }
                
            })
    }
        
    func removeAsset(assettoRemove : AssetDBModel){
        
        let loggedInUser : String = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? "NA"
        
        self.store
            .collection(COLLECTION_LIBRARY)
            .document(loggedInUser)
            .collection(COLLECTION_ASSETS)
            .document(assettoRemove.id!)
            .delete{error in
                
                if let err = error{
                    print(#function, "Error while deleting document \(err)")
                }else{
                    print(#function, "Book \(assettoRemove.coinId) deleted successfully")
                }
                
            }
    }
    
}

