//
//  UIHelper.swift
//  Github Followers
//
//  Created by Alvaro Gutierrez on 12/04/2020.
//  Copyright © 2020 alvarogjacome. All rights reserved.
//

import UIKit

enum UIHelper {
    enum Section {
        case main
    }
    
    static func threeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let viewWidth = view.bounds.width
        let padding: CGFloat = 12
        let availableSpace = viewWidth - (padding * 4)
        let itemWidth = availableSpace / 3

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.3)

        return flowLayout
    }
}
