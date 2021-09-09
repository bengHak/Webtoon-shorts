//
//  ToonEpisodesViewController.swift
//  WebtoonShorts
//
//  Created by byunghak on 2021/09/08.
//

import UIKit
import RxSwift
import Then
import SDWebImage

class EpisodesViewController: UIViewController {
    
    // MARK: - UI Components
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.bounces = false
    }
    
    let scrollViewContentView = UIView()
    
    let introImageView = UIImageView().then {
        $0.image = UIImage(named: "placeholder")
        $0.contentMode = .scaleToFill
    }

    let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24.0, weight: .semibold)
    }

    let writerLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16.0)
    }

    let dayLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16.0)
        $0.textColor = .secondaryLabel
    }

    let descriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16.0)
        $0.textColor = .secondaryLabel
        $0.numberOfLines = 1
        $0.lineBreakMode = .byTruncatingTail
        $0.lineBreakStrategy = .hangulWordPriority
    }
    
    let descriptionExpansionArrow = UILabel().then {
        $0.text = "⌵"
        $0.font = .systemFont(ofSize: 18.0)
        $0.textColor = .secondaryLabel
    }

    var tableViewEpisodes: UITableView!
    
    
    // MARK: - Properties
    let bag = DisposeBag()
    let viewModel = EpisodesViewModel()
    let toonInfo: ModelToon?
    
    
    // MARK: - Lifecycles
    init(model: ModelToon) {
        self.toonInfo = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let toonInfo = toonInfo else {
            return
        }
        view.backgroundColor = .systemBackground
        
        titleLabel.text = toonInfo.title
        writerLabel.text = toonInfo.writer
        dayLabel.text = "﹒ \(Day(rawValue: toonInfo.uploadDay!)?.dayLabel() ?? "")"
        descriptionLabel.text = toonInfo.description
        
        setUpView()
        setUpSubViews()
        bindRx()
        fetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            StorageManager.shared.downloadURL(for: self?.toonInfo?.introImageUrl ?? "") { result in
                switch result {
                case .success(let url):
                    DispatchQueue.main.async {
                        self?.introImageView.sd_setImage(with: url, completed: nil)
                    }
                case .failure(let error):
                    print("🔴 Failed to get download url: \(error)")
                }
            }
        }
    }
    
    // MARK: - Helpers
    private func fetch() {
        viewModel.fetchEpisodes(toonId: toonInfo?.id ?? -1)
    }
}
