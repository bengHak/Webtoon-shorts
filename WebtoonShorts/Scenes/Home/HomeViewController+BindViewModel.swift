//
//  HomeViewController+BindViewModel.swift
//  WebtoonShorts
//
//  Created by byunghak on 2021/09/05.
//
import UIKit

extension HomeViewController {
    
    func bindViewModel() {
        
        bindToonCollectionViews()
    }
    
    private func bindToonCollectionViews() {
        
        // 신작
        viewModel.output.mondayToons
            .filter { $0 != nil }
            .map { $0! }
            .bind(to: collectionViewNew.rx.items(cellIdentifier: ToonCollectionViewCell.identifier, cellType: ToonCollectionViewCell.self)) { index, toon, cell in
                cell.setData(with: toon, at: index)
                if index % 3 < 2 {
                    cell.layer.addBorder([.right], color: .secondarySystemFill, width: 0.5)
                }
            }.disposed(by: bag)
        
        // 월요 웹툰
        viewModel.output.mondayToons
            .filter { $0 != nil }
            .map { $0! }
            .bind(to: collectionViewMon.rx.items(cellIdentifier: ToonCollectionViewCell.identifier, cellType: ToonCollectionViewCell.self)) { index, toon, cell in
                cell.setData(with: toon, at: index)
                if index % 3 < 2 {
                    cell.layer.addBorder([.right], color: .secondarySystemFill, width: 0.5)
                }
            }.disposed(by: bag)
        
        // 화요 웹툰
        viewModel.output.mondayToons
            .filter { $0 != nil }
            .map { $0! }
            .bind(to: collectionViewTue.rx.items(cellIdentifier: ToonCollectionViewCell.identifier, cellType: ToonCollectionViewCell.self)) { index, toon, cell in
                cell.setData(with: toon, at: index)
                if index % 3 < 2 {
                    cell.layer.addBorder([.right], color: .secondarySystemFill, width: 0.5)
                }
            }.disposed(by: bag)
        
        // 수요 웹툰
        viewModel.output.mondayToons
            .filter { $0 != nil }
            .map { $0! }
            .bind(to: collectionViewWed.rx.items(cellIdentifier: ToonCollectionViewCell.identifier, cellType: ToonCollectionViewCell.self)) { index, toon, cell in
                cell.setData(with: toon, at: index)
                if index % 3 < 2 {
                    cell.layer.addBorder([.right], color: .secondarySystemFill, width: 0.5)
                }
            }.disposed(by: bag)
        
        // 목요 웹툰
        viewModel.output.mondayToons
            .filter { $0 != nil }
            .map { $0! }
            .bind(to: collectionViewThu.rx.items(cellIdentifier: ToonCollectionViewCell.identifier, cellType: ToonCollectionViewCell.self)) { index, toon, cell in
                cell.setData(with: toon, at: index)
                if index % 3 < 2 {
                    cell.layer.addBorder([.right], color: .secondarySystemFill, width: 0.5)
                }
            }.disposed(by: bag)
        
        // 금요 웹툰
        viewModel.output.mondayToons
            .filter { $0 != nil }
            .map { $0! }
            .bind(to: collectionViewFri.rx.items(cellIdentifier: ToonCollectionViewCell.identifier, cellType: ToonCollectionViewCell.self)) { index, toon, cell in
                cell.setData(with: toon, at: index)
                if index % 3 < 2 {
                    cell.layer.addBorder([.right], color: .secondarySystemFill, width: 0.5)
                }
            }.disposed(by: bag)
        
        // 토요 웹툰
        viewModel.output.mondayToons
            .filter { $0 != nil }
            .map { $0! }
            .bind(to: collectionViewSat.rx.items(cellIdentifier: ToonCollectionViewCell.identifier, cellType: ToonCollectionViewCell.self)) { index, toon, cell in
                cell.setData(with: toon, at: index)
                if index % 3 < 2 {
                    cell.layer.addBorder([.right], color: .secondarySystemFill, width: 0.5)
                }
            }.disposed(by: bag)
        
        // 일요 웹툰
        viewModel.output.mondayToons
            .filter { $0 != nil }
            .map { $0! }
            .bind(to: collectionViewSun.rx.items(cellIdentifier: ToonCollectionViewCell.identifier, cellType: ToonCollectionViewCell.self)) { index, toon, cell in
                cell.setData(with: toon, at: index)
                if index % 3 < 2 {
                    cell.layer.addBorder([.right], color: .secondarySystemFill, width: 0.5)
                }
            }.disposed(by: bag)
        
        // 완결 웹툰
        viewModel.output.mondayToons
            .filter { $0 != nil }
            .map { $0! }
            .bind(to: collectionViewFin.rx.items(cellIdentifier: ToonCollectionViewCell.identifier, cellType: ToonCollectionViewCell.self)) { index, toon, cell in
                cell.setData(with: toon, at: index)
                if index % 3 < 2 {
                    cell.layer.addBorder([.right], color: .secondarySystemFill, width: 0.5)
                }
            }.disposed(by: bag)
        
    }
    
}
