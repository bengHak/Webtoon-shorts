//
//  ReadViewController+BindViewModel.swift
//  WebtoonShorts
//
//  Created by byunghak on 2021/09/09.
//

import Foundation

extension ReadViewController {
    
    func bindViewModel() {
        bindCollectionView()
    }
    
    func bindCollectionView() {
        viewModel.output.imageUrls
            .filter { $0 != nil }
            .map { $0! }
            .bind(to: imageTableView
                    .rx
                    .items(cellIdentifier: ReadTableViewCell.identifier, cellType: ReadTableViewCell.self)) { index, imageUrlString, cell in
                cell.setData(urlString: imageUrlString)
                cell.selectionStyle = .none
            }
            .disposed(by: bag)
        
    }
}
