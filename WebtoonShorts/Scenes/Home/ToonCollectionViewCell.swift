//
//  ToonCollectionViewCell.swift
//  WebtoonShorts
//
//  Created by byunghak on 2021/09/04.
//

import UIKit
import SnapKit
import Then
import SDWebImage

class ToonCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Components
    
    let imageViewThumbnail = UIImageView().then {
        $0.image = UIImage(named: "placeholder")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    let title = UILabel().then {
        $0.font = .systemFont(ofSize: 16.0)
        $0.textColor = .label
    }
    
    let starPoint = UILabel().then {
        $0.font = .systemFont(ofSize: 12.0)
        $0.textColor = .red
    }
    
    let writer = UILabel().then {
        $0.font = .systemFont(ofSize: 12.0)
        $0.textColor = .secondaryLabel
    }
    
    // MARK: - Properties
    static let identifier = "ToonCollectionViewCell"
    
    
    // MARK: - LifeCycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    private func configureView() {
        [imageViewThumbnail, title, starPoint, writer].forEach {
            contentView.addSubview($0)
        }
        
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
        }
        
        imageViewThumbnail.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(contentView.snp.width)
        }
        
        title.snp.makeConstraints {
            $0.top.equalTo(imageViewThumbnail.snp.bottom).offset(4.0)
            $0.leading.trailing.equalToSuperview().inset(10.0)
        }
        
        starPoint.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(2.0)
            $0.leading.trailing.equalTo(title)
        }
        
        writer.snp.makeConstraints {
            $0.top.equalTo(starPoint.snp.bottom).offset(2.0)
            $0.leading.trailing.equalTo(title)
        }
    }
    
    func setData(with model: ModelToon, at index: Int) {
        if model.thumbnailUrl == "" {
            return
        }
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            StorageManager.shared.downloadURL(for: model.thumbnailUrl ?? "") { result in
                switch result {
                case .success(let url):
                    DispatchQueue.main.async {
                        self?.imageViewThumbnail.sd_setImage(with: url, completed: nil)
                    }
                case .failure(let error):
                    print("🔴 Failed to get thumbnail url: \(error)")
                }
            }
        }
        title.text = model.title ?? ""
        starPoint.text = title.text == "" ? "" : "★ \(model.star ?? 0)"
        writer.text = model.writer ?? ""
    }
}
