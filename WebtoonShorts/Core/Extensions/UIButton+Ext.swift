//
//  UIButton+Ext.swift
//  WebtoonShorts
//
//  Created by byunghak on 2021/09/04.
//

import UIKit
import SnapKit

extension UIButton {
    /// 홈 탭 버튼 스타일
    func homeTabButtonStyle(title: String?, enabled: Bool = false) {
        setTitle(title, for: .normal)
        snp.makeConstraints{
            $0.width.equalTo(50)
            $0.height.equalTo(40)
        }
        
        if enabled {
            setTitleColor(.white, for: .normal)
            backgroundColor = .green
            titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
            return
        }
        
        setTitleColor(.black, for: .normal)
        backgroundColor = .white
        titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
    }
}
