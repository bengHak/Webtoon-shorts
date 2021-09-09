//
//  HomeViewController+BaseViewController.swift
//  WebtoonShorts
//
//  Created by byunghak on 2021/09/04.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

extension HomeViewController: BaseViewController {
    
    func setUpView() {
        
        // 배너 스크롤 뷰
        scrollViewContentView.addSubview(scrollViewBannerImages)
        
        // 요일 탭 바
        allTabButtons.forEach{ stackTabButtons.addArrangedSubview($0) }
        scrollViewTabButtons.addSubview(stackTabButtons)
        scrollViewContentView.addSubview(scrollViewTabButtons)
        
        // 컬렉션 뷰
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = .zero
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        let cellWidth = UIScreen.main.bounds.width / 3.0
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth + 64.0)
        
        // 컬렉션 뷰 - 신작
        collectionViewNew = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionViewNew.backgroundColor = .clear
        collectionViewNew.register(ToonCollectionViewCell.self, forCellWithReuseIdentifier: ToonCollectionViewCell.identifier)
        
        // 컬렉션 뷰 - 월요일
        collectionViewMon = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionViewMon.backgroundColor = .clear
        collectionViewMon.register(ToonCollectionViewCell.self, forCellWithReuseIdentifier: ToonCollectionViewCell.identifier)
        
        // 컬렉션 뷰 - 화요일
        collectionViewTue = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionViewTue.backgroundColor = .clear
        collectionViewTue.register(ToonCollectionViewCell.self, forCellWithReuseIdentifier: ToonCollectionViewCell.identifier)
        
        // 컬렉션 뷰 - 수요일
        collectionViewWed = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionViewWed.backgroundColor = .clear
        collectionViewWed.register(ToonCollectionViewCell.self, forCellWithReuseIdentifier: ToonCollectionViewCell.identifier)
        
        // 컬렉션 뷰 - 목요일
        collectionViewThu = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionViewThu.backgroundColor = .clear
        collectionViewThu.register(ToonCollectionViewCell.self, forCellWithReuseIdentifier: ToonCollectionViewCell.identifier)
        
        // 컬렉션 뷰 - 금요일
        collectionViewFri = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionViewFri.backgroundColor = .clear
        collectionViewFri.register(ToonCollectionViewCell.self, forCellWithReuseIdentifier: ToonCollectionViewCell.identifier)
        
        // 컬렉션 뷰 - 토요일
        collectionViewSat = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionViewSat.backgroundColor = .clear
        collectionViewSat.register(ToonCollectionViewCell.self, forCellWithReuseIdentifier: ToonCollectionViewCell.identifier)
        
        // 컬렉션 뷰 - 일요일
        collectionViewSun = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionViewSun.backgroundColor = .clear
        collectionViewSun.register(ToonCollectionViewCell.self, forCellWithReuseIdentifier: ToonCollectionViewCell.identifier)
        
        // 컬렉션 뷰 - 완결
        collectionViewFin = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionViewFin.backgroundColor = .clear
        collectionViewFin.register(ToonCollectionViewCell.self, forCellWithReuseIdentifier: ToonCollectionViewCell.identifier)
        
        allToonCollectionViews.forEach {
            $0.rx.setDelegate(self).disposed(by: bag)
            viewScrollCollectionContentView.addSubview($0)
        }
        
        scrollViewCollections.addSubview(viewScrollCollectionContentView)
        scrollViewContentView.addSubview(scrollViewCollections)
        
        scrollView.addSubview(scrollViewContentView)
        
        view.addSubview(scrollView)
    }
    
    func setUpSubViews() {
        
        // 루트 스크롤뷰
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // 루트 스크롤뷰 컨텐트 뷰
        scrollViewContentView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        // 배너 스크롤 뷰
        scrollViewBannerImages.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        // 탭 스크롤뷰
        scrollViewTabButtons.snp.makeConstraints{
            $0.top.equalTo(scrollViewBannerImages.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(stackTabButtons.snp.height)
        }
        
        // 탭 버튼 바
        stackTabButtons.snp.makeConstraints {
            $0.top.equalToSuperview()
        }
        
        // 웹툰 목록 스크롤 뷰
        scrollViewCollections.snp.makeConstraints {
            $0.top.equalTo(stackTabButtons.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        viewScrollCollectionContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(view.frame.width * 9)
            $0.height.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        // 신작 웹툰 컬렉션 뷰
        collectionViewNew.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(view.frame.width)
        }
        
        // 월요 웹툰 컬렉션 뷰
        collectionViewMon.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(collectionViewNew.snp.trailing)
            $0.width.equalTo(view.frame.width)
        }
        
        // 화요 웹툰 컬렉션 뷰
        collectionViewTue.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(collectionViewMon.snp.trailing)
            $0.width.equalTo(view.frame.width)
        }
        
        // 수요 웹툰 컬렉션 뷰
        collectionViewWed.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(collectionViewTue.snp.trailing)
            $0.width.equalTo(view.frame.width)
        }
        
        // 목요 웹툰 컬렉션 뷰
        collectionViewThu.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(collectionViewWed.snp.trailing)
            $0.width.equalTo(view.frame.width)
        }
        
        // 금요 웹툰 컬렉션 뷰
        collectionViewFri.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(collectionViewThu.snp.trailing)
            $0.width.equalTo(view.frame.width)
        }
        
        // 토요 웹툰 컬렉션 뷰
        collectionViewSat.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(collectionViewFri.snp.trailing)
            $0.width.equalTo(view.frame.width)
        }
        
        // 일요 웹툰 컬렉션 뷰
        collectionViewSun.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(collectionViewSat.snp.trailing)
            $0.width.equalTo(view.frame.width)
        }
        
        // 완결 웹툰 컬렉션 뷰
        collectionViewFin.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(collectionViewSun.snp.trailing)
            $0.width.equalTo(view.frame.width)
        }
    }
    
    func createBanners() {
        for i in 0..<5 {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "banner_\(i+1)")
            imageView.contentMode = .scaleAspectFill
            imageView.frame = CGRect(x: view.frame.width * CGFloat(i),
                                     y: 0,
                                     width: view.frame.width,
                                     height: scrollViewBannerImages.frame.height)
            
            scrollViewBannerImages.contentSize.width = self.view.frame.width * CGFloat(1+i)
            scrollViewBannerImages.addSubview(imageView)
        }
    }
    
    func createDayButtons() {
        let today = Date()
        let day = (Calendar.current.component(.weekday, from: today) + 5) % 7 // 월: 0 ~ 일: 6
        let dayText = DayTab(rawValue: day+1)!.kor()
        
        let buttonTexts: [String] = DayTab.allCases.map { $0.kor() }
        
        for buttonText in buttonTexts {
            let button = UIButton(type: .system).then {
                $0.homeTabButtonStyle(title: buttonText, enabled: buttonText == dayText ? true : false)
            }
            allTabButtons.append(button)
        }
    }
    
}
