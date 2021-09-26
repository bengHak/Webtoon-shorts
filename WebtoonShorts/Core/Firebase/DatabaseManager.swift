//
//  DatabaseManager.swift
//  WebtoonShorts
//
//  Created by byunghak on 2021/09/06.
//

import Foundation
import Firebase

final class DatabaseManager {
    
    public static let shared = DatabaseManager()
    
    private let database = Firestore.firestore()
}

extension DatabaseManager {
    
    // MARK: Get Toons
    /// Gets toons (Monday through Friday, new, finished)
    public func getToons(completion: @escaping (Result<[ModelToon], Error>) -> Void) {
        database.collection("toons").getDocuments() { (snapshot, error) in
            if let error = error {
                print("🔴 Error getting documents: \(error)")
                completion(.failure(DatabaseError.failedToFetch))
                return
            }

            var toons: [ModelToon] = []
            
            for document in snapshot!.documents {
                let data: [String:Any] = document.data()
                
                guard let toonId = data["id"] as? Int,
                      let title = data["title"] as? String,
                      let day = data["day"] as? Int,
                      let star = data["star"] as? Double,
                      let views = data["views"] as? Int,
                      let writer = data["writer"] as? String,
                      let description = data["description"] as? String,
                      let lastUpdatedTime = data["lastUpdatedTime"] as? Int,
                      let thumbnailUrl = data["thumbnailUrl"] as? String,
                      let introImageUrl = data["introImageUrl"] as? String else {
                    print("🔴 Failed to convert: \(data)")
                    completion(.failure(DatabaseError.failedToFetch))
                    return
                }
                
                toons.append(ModelToon(id: toonId,
                                       thumbnailUrl: thumbnailUrl,
                                       introImageUrl: introImageUrl,
                                       title: title,
                                       writer: writer,
                                       uploadDay: day,
                                       description: description,
                                       star: star,
                                       views: views,
                                       lastUpdatedTime: lastUpdatedTime))
            }
            print("🟢 Success to fetch toons")
            while toons.count % 3 != 0 {
                toons.append(ModelToon(id: -1,
                                       thumbnailUrl: "",
                                       introImageUrl: "",
                                       title: "",
                                       writer: "",
                                       uploadDay: 0,
                                       description: "",
                                       star: 0,
                                       views: 0,
                                       lastUpdatedTime: 0))
            }
            completion(.success(toons))
        }
    }
    
    /// Get episodes
    func getEpisodes(toonId: Int, completion: @escaping (Result<[ModelEpisode], Error>) -> Void) {
        print("🟢 fetching episodes")
        database.collection("episodes").getDocuments() { (snapshot, error) in
            if let error = error {
                print("🔴 Error getting documents: \(error)")
                completion(.failure(DatabaseError.failedToFetch))
                return
            }
            
            var episodes:[ModelEpisode] = []
            
            for document in snapshot!.documents {
                let data: [String:Any] = document.data()

                guard let epId = data["id"] as? Int,
                      let tId = data["toonId"] as? Int,
                      let title = data["title"] as? String,
                      let epNum = data["epNum"] as? Int,
                      let star = data["star"] as? Double,
                      let uploadedDate = data["uploadedDate"] as? Int,
                      let cuts = data["cuts"] as? Int,
                      let thumbnailUrl = data["thumbnailUrl"] as? String else {
                    print("🔴 Failed to convert: \(data)")
                    completion(.failure(DatabaseError.failedToFetch))
                    return
                }
                
                if toonId != tId {
                    continue
                }
                
                episodes.append(ModelEpisode(id: epId,
                                             toonId: tId,
                                             title: title,
                                             epNum: epNum,
                                             star: star,
                                             uploadedDate: uploadedDate,
                                             cuts: cuts,
                                             thumbnailUrl: thumbnailUrl))
            }
            
            episodes.sort {
                guard let leftEpNum = $0.epNum,
                      let rightEpNum = $1.epNum else {
                          return false
                      }
                return leftEpNum < rightEpNum
            }
            
            completion(.success(episodes))
        }
    }
    
}

enum DatabaseError: Error {
    case failedToFetch
}
