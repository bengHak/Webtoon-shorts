//
//  StorageManager.swift
//  WebtoonShorts
//
//  Created by byunghak on 2021/09/07.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
    
    public func downloadURL(for path: String, completion: @escaping (Result<URL, Error>) -> Void) {
        if let signedUrl = SignedUrlCache.shared.url(for: path) {
            completion(.success(signedUrl))
            print("🟢 Retrieve url cached -> \(path)")
            return
        }
        
        let reference = storage.child(path)
        reference.downloadURL{ url, error in
            guard let url = url, error == nil else {
                if !path.isEmpty {
                    print(String(describing: error))
                }
                completion(.failure(StorageErrors.failedToGetDownloadUrl))
                return
            }
           
            SignedUrlCache.shared.insertRelativePath(url, for: path)
            print("🟢 url cached -> \(path)")
            completion(.success(url))
        }
    }
}


// MARK: - Error
extension StorageManager {
    public enum StorageErrors: Error {
        case failedToUpload
        case failedToGetDownloadUrl
    }
}
