//
//  ReadViewModel.swift
//  WebtoonShorts
//
//  Created by byunghak on 2021/09/09.
//

import Foundation
import RxSwift
import RxCocoa

protocol ReadOutput {
    /// 에러
    var onError: PublishRelay<ReadViewModel.ReadError> { get }
    /// 이미지 목록
    var imageUrls: PublishRelay<[String]?> { get }
}

class ReadViewModel {
    
    var output = Output()
    
    struct Output: ReadOutput {
        var onError = PublishRelay<ReadViewModel.ReadError>()
        var imageUrls = PublishRelay<[String]?>()
    }
    
}


// MARK: - Methods
extension ReadViewModel {
        
    func fetchImageUrls(episodeId: Int, cutCount: Int) {
        var imageUrls:[String] = []
        for i in 0..<cutCount {
            imageUrls.append("toonImages/ep_\(episodeId)/cut_\(i).jpg")
        }
        output.imageUrls.accept(imageUrls)
        print("🟢 Success to fetch image urls")
    }
}

// MARK: - Error
extension ReadViewModel {
    
    enum ReadError: Error {
        case loadingError
    }
}
