//
//  EpisodesViewController+BindRx.swift
//  WebtoonShorts
//
//  Created by byunghak on 2021/09/08.
//

import UIKit
import RxSwift
import RxCocoa

extension EpisodesViewController {
    
    func bindRx() {
        bindViewModel()
        bindTableViewSelected()
        bindViewTapped()
    }
    
    func bindTableViewSelected() {
        
        Observable.zip(tableViewEpisodes.rx.itemSelected,
                       tableViewEpisodes.rx.modelSelected(ModelEpisode.self))
            .subscribe(onNext: { [weak self] (indexPath, model) in
                let vc = ReadViewController(episode: model)
                vc.title = model.title
                self?.tableViewEpisodes.deselectRow(at: indexPath, animated: false)
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: bag)
    }
    
    func bindViewTapped() {
        descriptionLabel
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                DispatchQueue.main.async {
                    if self?.descriptionLabel.numberOfLines == 0 {
                        self?.descriptionLabel.numberOfLines = 1
                        self?.descriptionExpansionArrow.text = "⌵"
                    } else {
                        self?.descriptionLabel.numberOfLines = 0
                        self?.descriptionExpansionArrow.text = "˄"
                    }
                }
            })
            .disposed(by: bag)
    }
    
}
