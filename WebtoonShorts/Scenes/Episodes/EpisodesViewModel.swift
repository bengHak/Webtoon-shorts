//
//  EpisodeViewModel.swift
//  WebtoonShorts
//
//  Created by byunghak on 2021/09/08.
//

import Foundation
import RxSwift
import RxCocoa

protocol EpisodesOutput {
    /// 에러
    var onError: PublishRelay<EpisodesViewModel.EpisodesError> { get }
    /// 에피소드 목록
    var episodes: PublishRelay<[ModelEpisode]?> { get }
}

class EpisodesViewModel {
    
    var output = Output()
    
    struct Output: EpisodesOutput {
        var onError = PublishRelay<EpisodesViewModel.EpisodesError>()
        var episodes = PublishRelay<[ModelEpisode]?>()
    }
}

// MARK: - Methods
extension EpisodesViewModel {
    
    func fetchEpisodes(toonId: Int) {
        DatabaseManager.shared.getEpisodes(toonId: toonId) { [weak self] result in
            switch result {
            case .success(let episodes):
                print(episodes)
                self?.output.episodes.accept(episodes)
            case .failure(let error):
                print("🔴 \(error)")
            }
        }
    }
}

// MARK: - Error
extension EpisodesViewModel {
    
    enum EpisodesError: Error {
        case loadingError
    }
}
