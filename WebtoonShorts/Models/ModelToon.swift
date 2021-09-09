//
//  Toon.swift
//  WebtoonShorts
//
//  Created by byunghak on 2021/09/06.
//

import Foundation

struct ModelToon: Decodable {
    var id: Int?
    var thumbnailUrl: String?
    var introImageUrl: String?
    var title: String?
    var writer: String?
    var uploadDay: Int? // 0 = 월
    var description: String?
    var star: Double?
    var views: Int?
    var lastUpdatedTime: Int?
}
