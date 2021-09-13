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

    // MARK: - Helpers
    func setUI() {
        contentView.addSubview(readImageView)
        
        readImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setData(urlString: String) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            StorageManager.shared.downloadURL(for: urlString) { [weak self] result in
                switch result {
                case .success(let url):
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.readImageView.sd_setImage(with: url, completed: nil)
                    }
                case .failure(let error):
                    print("🔴 Failed to get download url: \(error)")
                }
            }
        }
    }
}
