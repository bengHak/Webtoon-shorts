//
//  ReadViewController+BindRx.swift
//  WebtoonShorts
//
//  Created by byunghak on 2021/09/09.
//

import Foundation

extension ReadViewController {
    
    func bindRx() {
        bindGesture()
        bindViewModel()
    }
    
    // TODO: 위 아래로 스크롤 했을 때
    func bindGesture() {
        imageTableView
            .rx
            .gesture(.swipe(direction: .up))
            .subscribe(onNext: { [weak self] _ in
                DispatchQueue.main.async {
                    guard let self = self,
                          let nav = self.navigationController,
                          let tabBar = self.tabBarController else {
                        return
                    }
                    
                    nav.setNavigationBarHidden(true, animated: true)
                    tabBar.tabBar.isHidden = true
                }
            })
            .disposed(by: bag)
        
        imageTableView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self,
                      let nav = self.navigationController,
                      let tabBar = self.tabBarController else {
                    return
                }

                DispatchQueue.main.async {
                    nav.setNavigationBarHidden(!nav.isNavigationBarHidden, animated: true)
                    tabBar.tabBar.isHidden = !tabBar.tabBar.isHidden
                }
            })
            .disposed(by: bag)
    }
}
