//
//  ReadTableViewCell.swift
//  WebtoonShorts
//
//  Created by byunghak on 2021/09/09.
//

import UIKit
import SnapKit
import SDWebImage
import Then

class ReadTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    let readImageView = UIImageView().then {
        $0.image = UIImage(named: "placeholder")
        $0.contentMode = .scaleAspectFit
    }
    
    
    // MARK: - Properties
    static let identifier = "ReadTableViewCell"
    
    // MARK: - Lifecycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: ReadTableViewCell.identifier)
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        readImageView.sd_cancelCurrentImageLoad()
        readImageView.image = nil
        updateLayout()
    }

    // MARK: - Helpers
    func setUI() {
        contentView.addSubview(readImageView)
        
        readImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            let w = UIScreen.main.bounds.width
            let h = Float(w) * Float((readImageView.image?.getImageRatio())!)
            $0.width.equalTo(w)
            $0.height.equalTo(h)
        }
    }
    
    func updateLayout(){
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    // TODO: URL 가져오기 코드 ViewModel에 보내기
    func setData(urlString: String) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            StorageManager.shared.downloadURL(for: urlString) { result in
                switch result {
                case .success(let url):
                    DispatchQueue.main.async {
                        self?.readImageView.sd_setImage(with: url, completed: nil)
                    }
                case .failure(let error):
                    print("🔴 Failed to get download url: \(error)")
                }
            }
        }
    }
}
