//
//  BaseCollectionViewFlowLayout.swift
//  Library
//
//  Created by Duong Le Bac on 3/2/18.
//  Copyright © 2018 Eastgate Software. All rights reserved.
//

import UIKit

class BaseCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attribute = super.layoutAttributesForItem(at: indexPath)
        self.modifyLayoutAttribute(attribute: attribute)
        return attribute
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        for attribute in attributes {
            self.modifyLayoutAttribute(attribute: attribute)
        }
        return attributes
    }
    
    func modifyLayoutAttribute(attribute: UICollectionViewLayoutAttributes?) {
        guard let attribute = attribute else {
            return
        }
        let contentSize = self.collectionViewContentSize
        var frame = attribute.frame
        frame.origin.x = contentSize.width - attribute.frame.origin.x - attribute.frame.size.width
        frame.origin.y = contentSize.height - attribute.frame.origin.y - attribute.frame.size.height
        attribute.frame = frame
    }
}
