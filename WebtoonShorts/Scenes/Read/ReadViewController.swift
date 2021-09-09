//
//  ReadViewController.swift
//  WebtoonShorts
//
//  Created by byunghak on 2021/09/09.
//

import UIKit
import RxSwift
import Then

class ReadViewController: UIViewController {
    
    // MARK: - UI Components
    
    var scrollViewContentView = UIView()
    
    var imageTableView: UITableView!
    
    // MARK: - Properties
    let bag = DisposeBag()
    
    let viewModel = ReadViewModel()

    let episode: ModelEpisode
    
    // MARK: - Lifecycles
    init(episode: ModelEpisode) {
        self.episode = episode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setUpView()
        setUpSubViews()
        bindRx()
        fetch()
    }

    
    // MARK: - Helpers
    private func fetch() {
        guard let id = episode.id,
              let cutCount = episode.cuts else {
            print("🔴 Error to get episode id, cut count")
            return
        }
        viewModel.fetchImageUrls(episodeId: id, cutCount: cutCount)
    }
}
