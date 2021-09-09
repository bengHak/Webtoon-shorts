//
//  HomeViewModel.swift
//  WebtoonShorts
//
//  Created by byunghak on 2021/09/04.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeDependency {
    
}

protocol HomeOutput {
    /// 에러
    var onError: PublishRelay<HomeViewModel.HomeError> { get }
    /// 신작
    var newToons: PublishRelay<[ModelToon]?> { get }
    /// 월요 웹툰
    var mondayToons: PublishRelay<[ModelToon]?> { get }
}

class HomeViewModel {

    var output = Output()
    
    struct Output: HomeOutput {
        var onError = PublishRelay<HomeViewModel.HomeError>()
        var newToons = PublishRelay<[ModelToon]?>()
        var mondayToons = PublishRelay<[ModelToon]?>()
    }
    
}

// MARK: - Methods
extension HomeViewModel {
    
    func fetchToons() {
        DatabaseManager.shared.getToons() { [weak self] result in
            switch result {
            case .success(let toons):
                self?.output.mondayToons.accept(toons)
            case .failure(let error):
                self?.output.onError.accept(.toonsLoadingError)
                print("🔴 Failed to get toons: \(error)")
            }
        }
    }
    
}

// MARK: - Error
extension HomeViewModel {
    
    enum HomeError: Error {
        case toonsLoadingError
        case newLoadingError
        case mondayLoadingError
        case tuesdayLoadingError
        case wednesdayLoadingError
        case thursdayLoadingError
        case fridayLoadingError
        case saturdayLoadingError
        case sundayLoadingError
        case finishLoadingError
    }
}
