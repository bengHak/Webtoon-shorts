//
//  EpisodesViewController+BaseController.swift
//  WebtoonShorts
//
//  Created by byunghak on 2021/09/08.
//

import UIKit
import SnapKit

extension EpisodesViewController: BaseViewController {
    
    func setUpView() {
        // 인트로 이미지 뷰
        scrollViewContentView.addSubview(introImageView)
        
        // 설명 뷰
        [titleLabel, writerLabel, dayLabel, descriptionLabel, descriptionExpansionArrow].forEach { scrollViewContentView.addSubview($0) }
        
        tableViewEpisodes = UITableView()
        tableViewEpisodes.backgroundColor = .systemBackground
        tableViewEpisodes.estimatedRowHeight = 80
        tableViewEpisodes.rowHeight = UITableView.automaticDimension
        tableViewEpisodes.register(EpisodeTableViewCell.self, forCellReuseIdentifier: EpisodeTableViewCell.identifier)
        scrollViewContentView.addSubview(tableViewEpisodes)
        
        scrollView.addSubview(scrollViewContentView)
        view.addSubview(scrollView)
    }
    
    func setUpSubViews() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollViewContentView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        
        introImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10.0)
            $0.leading.trailing.equalToSuperview().inset(30.0)
            $0.height.equalTo(140.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(introImageView.snp.bottom).offset(10.0)
            $0.leading.equalToSuperview().inset(16.0)
        }
        
        writerLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            $0.leading.equalTo(titleLabel)
        }
        
        dayLabel.snp.makeConstraints {
            $0.top.equalTo(writerLabel)
            $0.leading.equalTo(writerLabel.snp.trailing).offset(4.0)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(writerLabel.snp.bottom).offset(4.0)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(32.0)
        }
        
        descriptionExpansionArrow.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel)
            $0.leading.equalTo(descriptionLabel.snp.trailing).offset(4.0)
        }
        
        tableViewEpisodes.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20.0)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
