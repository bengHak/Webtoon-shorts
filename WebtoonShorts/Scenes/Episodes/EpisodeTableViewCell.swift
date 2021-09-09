//
//  EpisodeTableViewCell.swift
//  WebtoonShorts
//
//  Created by byunghak on 2021/09/08.
//

import UIKit
import SDWebImage

class EpisodeTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    let imageViewThumbnail = UIImageView().then{
        $0.image = UIImage(named: "placeholder")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18.0)
        $0.textColor = .label
    }
    
    let starPointLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14.0)
        $0.textColor = .secondaryLabel
    }
    
    let uploadedDateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14.0)
        $0.textColor = .secondaryLabel
    }
    
    
    // MARK: - Properties
    static let identifier = "EpisodeTableViewCell"
    

    // MARK: - Lifecycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: EpisodeTableViewCell.identifier)
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    private func setUI() {
        [imageViewThumbnail, titleLabel, starPointLabel, uploadedDateLabel].forEach {
            contentView.addSubview($0)
        }
        
        contentView.snp.makeConstraints {
            $0.height.equalTo(80.0)
        }
        
        imageViewThumbnail.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(10.0)
            $0.width.equalTo(90.0)
            $0.height.equalTo(80.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18.0)
            $0.leading.equalTo(imageViewThumbnail.snp.trailing).offset(10.0)
        }
        
        starPointLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6.0)
            $0.leading.equalTo(titleLabel)
        }
        
        uploadedDateLabel.snp.makeConstraints {
            $0.top.equalTo(starPointLabel)
            $0.leading.equalTo(starPointLabel.snp.trailing).offset(10.0)
        }
        
    }
    
    func setData(model: ModelEpisode) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            StorageManager.shared.downloadURL(for: model.thumbnailUrl ?? "") { result in
                switch result {
                case .success(let url):
                    DispatchQueue.main.async {
                        self?.imageViewThumbnail.sd_setImage(with: url, completed: nil)
                    }
                case .failure(let error):
                    print("🔴 Failed to get download url: \(error)")
                }
            }
        }
        
        let date = Date(timeIntervalSince1970: TimeInterval(model.uploadedDate ?? 0))
        let dateFormmater = DateFormatter()
        dateFormmater.dateStyle = .medium
        dateFormmater.locale = Locale(identifier: "ko_KR")
        
        titleLabel.text = model.title
        starPointLabel.text = "★ \(model.star ?? 0)"
        uploadedDateLabel.text = dateFormmater.string(from: date)
    }
    
}
