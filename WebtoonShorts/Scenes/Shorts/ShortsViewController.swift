//
//  ShortsViewController.swift
//  WebtoonShorts
//
//  Created by byunghak on 2021/09/04.
//

import UIKit
import SnapKit

final class ShortsViewController: UIViewController {

    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Shorts"
        view.backgroundColor = .systemBackground
        
        setup()
    }
    
    // MARK: - Setup
    func setup() {
    }

    /*
        TODO:
        1) 세로 collection view
        2) 가로 컬렉션
        3) 회차 목록 보러가기 뷰 -> navigation controller
     */
}
