//
//  HomeViewController.swift
//  WebtoonShorts
//
//  Created by byunghak on 2021/09/04.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then

final class HomeViewController: UIViewController {

// MARK: - UI Components
    
    /// 루트 스크롤뷰
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.bounces = false
    }
    /// 루트 스크롤 컨텐츠 뷰
    lazy var scrollViewContentView = UIView()

    /// 배너 이미지 스크롤 뷰
    let scrollViewBannerImages = UIScrollView().then {
        $0.backgroundColor = .secondarySystemBackground
        $0.showsHorizontalScrollIndicator = false
        $0.isPagingEnabled = true
        $0.frame = CGRect(x: 0, y: 0, width: 0, height: 150)
    }
    
    /// 탭 뷰
    let scrollViewTabButtons = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
        $0.bounces = false
    }
    
    /// 탭 스택
    let stackTabButtons = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = .zero
        $0.distribution = .fill
        $0.alignment = .fill
    }

    /// 모든 탭 버튼
    var allTabButtons = [UIButton]()
    
    /// 요일별 컬렉션뷰 가로 스크롤 뷰
    let scrollViewCollections = UIScrollView().then {
        $0.isPagingEnabled = true
    }
    let viewScrollCollectionContentView = UIView()
    
    /// 신작
    var collectionViewNew: UICollectionView!
    /// 월
    var collectionViewMon: UICollectionView!
    /// 화
    var collectionViewTue: UICollectionView!
    /// 수
    var collectionViewWed: UICollectionView!
    /// 목
    var collectionViewThu: UICollectionView!
    /// 금
    var collectionViewFri: UICollectionView!
    /// 토
    var collectionViewSat: UICollectionView!
    /// 일
    var collectionViewSun: UICollectionView!
    /// 완결
    var collectionViewFin: UICollectionView!
    
    /// 모든 컬렉션 뷰
    var allToonCollectionViews: [UICollectionView] {
        return [collectionViewNew, collectionViewMon, collectionViewTue, collectionViewWed, collectionViewThu, collectionViewFri, collectionViewSat, collectionViewSun, collectionViewFin]
    }
    
// MARK: - Properties
    
    let bag = DisposeBag()
    let viewModel = HomeViewModel()
    
    let isScrolling = BehaviorRelay<Bool>(value: false)
    
    /// 선택된 요일
    var scrollViewCollectionSelectedIndex: Int {
        return Int(scrollViewCollections.contentOffset.x / view.frame.width)
    }

// MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        view.backgroundColor = .systemBackground
        createBanners()
        createDayButtons()
        setUpView()
        setUpSubViews()
        bindRx()
        fetch()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollViewTabButtons.contentSize = CGSize(width: stackTabButtons.frame.width,
                                                  height: stackTabButtons.frame.height)
        
        scrollView.contentSize = CGSize(width: scrollViewContentView.frame.width,
                                        height: scrollViewContentView.frame.height)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - Helpers
    private func fetch() {
        viewModel.fetchToons()
    }
}
