//
//  ShortsCollectionViewCell.swift
//  WebtoonShorts
//
//  Created by byunghak on 2021/09/24.
//

import UIKit
import Then

class ShortsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    let scrollView = UIScrollView().then {
        $0.isPagingEnabled = true
    }
    
    let horizontalCollectionView = UICollectionView()
    
    
    // MARK: - Properties
    static let identifier = "ShortsCollectionViewCell"
    
    
    // MARK: - Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configureView() {
        
    }
    
    func setData() {
        
    }
    
}
