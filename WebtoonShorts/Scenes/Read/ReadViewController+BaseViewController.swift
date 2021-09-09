//
//  ReadViewController+BaseViewController.swift
//  WebtoonShorts
//
//  Created by byunghak on 2021/09/09.
//

import UIKit
import SnapKit

extension ReadViewController: BaseViewController {
    func setUpView() {
        
        imageTableView = UITableView()
        imageTableView.delegate = self
        imageTableView.bounces = false
        imageTableView.backgroundColor = .clear
        imageTableView.separatorStyle = .none
        imageTableView.register(ReadTableViewCell.self, forCellReuseIdentifier: ReadTableViewCell.identifier)
        
        scrollViewContentView.addSubview(imageTableView)
        view.addSubview(scrollViewContentView)
    }
    
    func setUpSubViews() {        
        scrollViewContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        imageTableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    
}
