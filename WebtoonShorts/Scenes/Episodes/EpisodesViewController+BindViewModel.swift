//
//  EpisodesViewController+BindViewModel.swift
//  WebtoonShorts
//
//  Created by byunghak on 2021/09/08.
//

import Foundation

extension EpisodesViewController {
    
    func bindViewModel() {
        bindTableView()
    }
    
    func bindTableView () {
        viewModel.output.episodes
            .filter { $0 != nil }
            .map { $0! }
            .bind(to: tableViewEpisodes.rx.items(cellIdentifier: EpisodeTableViewCell.identifier, cellType: EpisodeTableViewCell.self)) { index, episode, cell in
                cell.setData(model: episode)
            }
            .disposed(by: bag)
    }
}
