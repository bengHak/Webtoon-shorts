//
//  UIImage+Ext.swift
//  WebtoonShorts
//
//  Created by byunghak on 2021/09/10.
//

import UIKit

extension UIImage {
    func getImageRatio() -> CGFloat {
        let imageRatio = CGFloat(self.size.width / self.size.height)
        return imageRatio
    }
}
