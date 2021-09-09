//
//  HomeViewController+BindRx.swift
//  WebtoonShorts
//
//  Created by byunghak on 2021/09/05.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

extension HomeViewController {
    
    func bindRx() {
        
        bindScrollViewCollections()
        bindCollectionViews()
        bindTabButtons()
        bindViewModel()
        
    }

    private func bindScrollViewCollections() {
        scrollViewCollections.rx
            .contentOffset
            .subscribe(onNext: { [weak self] offset in
                
                guard let viewWidth = self?.view.frame.width else {
                    return
                }
                
                if Int(offset.x) % Int(viewWidth) != 0 {
                    self?.isScrolling.accept(true)
                    return
                } else {
                    self?.isScrolling.accept(false)
                }
                
                self?.changeTabButtonColors()
            })
            .disposed(by: bag)
    }
    
    private func bindCollectionViews() {
        allToonCollectionViews.forEach {
            $0.rx.modelSelected(ModelToon.self)
                .subscribe(onNext: { [weak self] modelToon in
                    guard let toonId = modelToon.id,
                          toonId != -1 else {
                        return
                    }
                    
                    let vc = EpisodesViewController(model: modelToon)
                    vc.title = modelToon.title
                    self?.navigationController?.pushViewController(vc, animated: true)
                })
                .disposed(by: bag)
        }
    }
    
    private func bindTabButtons() {
        allTabButtons.enumerated().forEach { index, button in
            button.rx
                .tap
                .subscribe(onNext: { [weak self] in
                    guard let self = self else { return }
                    self.moveCollectionScrollView(to: CGFloat(index))
                })
                .disposed(by: bag)
        }
    }
    
    private func moveCollectionScrollView(to index: CGFloat) {
        isScrolling.accept(true)
        
        let point = CGPoint(x: view.frame.width * index, y: 0.0)
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.scrollViewCollections.contentOffset = point
        } completion: { _ in
            self.isScrolling.accept(false)
            self.changeTabButtonColors()
        }
    }
    
    private func changeTabButtonColors() {
        let index = scrollViewCollectionSelectedIndex
        
        for (buttonIndex, button) in self.allTabButtons.enumerated() {
            button.homeTabButtonStyle(title: button.currentTitle, enabled: index == buttonIndex)
        }
    }
}
