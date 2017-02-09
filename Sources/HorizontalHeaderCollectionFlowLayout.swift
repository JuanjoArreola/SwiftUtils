//
//  HorizontalHeaderCollectionFlowLayout.swift
//  SwiftUtils
//
//  Created by Juan Jose Arreola on 07/02/17.
//  Copyright © 2017 Juanjo. All rights reserved.
//

import UIKit

open class HorizontalHeaderCollectionFlowLayout: UICollectionViewFlowLayout {
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return super.layoutAttributesForElements(in: rect) }
        var attributesArray = super.layoutAttributesForElements(in: rect)
        
        var missingSections = Set<Int>()
        attributesArray?.forEach({ if $0.representedElementCategory == .cell { missingSections.insert(($0.indexPath as NSIndexPath).section) } })
        attributesArray?.forEach({ if $0.representedElementKind == UICollectionElementKindSectionHeader { missingSections.remove(($0.indexPath as NSIndexPath).section) } })
        
        
        missingSections.forEach { (section) in
            let indexPath = IndexPath(item: 0, section: section)
            if let attributes = layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: indexPath) {
                attributesArray?.append(attributes)
            }
        }
        
        let contentOffset = collectionView.contentOffset
        attributesArray?.forEach({ (attributes: UICollectionViewLayoutAttributes) in
            if attributes.representedElementKind != UICollectionElementKindSectionHeader { return }
            
            let section = (attributes.indexPath as NSIndexPath).section
            let items = collectionView.numberOfItems(inSection: section)
            
            var firstAttributes: UICollectionViewLayoutAttributes!
            var lastAttributes: UICollectionViewLayoutAttributes!
            if items > 0 {
                firstAttributes = layoutAttributesForItem(at: IndexPath(item: 0, section: section))
                lastAttributes = layoutAttributesForItem(at: IndexPath(item: max(items - 1, 0), section: section))
            } else {
                firstAttributes = layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: IndexPath(item: 0, section: section))
                lastAttributes = layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: IndexPath(item: max(items - 1, 0), section: section))
            }
            let topHeaderWidth = items > 0 ? attributes.frame.width : 0
            let bottomHeaderWidth = attributes.frame.width
            var frame = UIEdgeInsetsInsetRect(attributes.frame, collectionView.contentInset)
            frame = UIEdgeInsetsInsetRect(frame, sectionInset)
            
            var origin = frame.origin
            let position = contentOffset.x + collectionView.contentInset.left
            origin.x = min(max(position, firstAttributes.frame.minX - topHeaderWidth), lastAttributes.frame.maxX - bottomHeaderWidth + sectionInset.right * 2 + sectionInset.left * 2)
            origin.y = firstAttributes.frame.origin.y
            
            attributes.zIndex = 1024
            attributes.frame = CGRect(origin: origin, size: CGSize(width: frame.width, height: firstAttributes.frame.height))
        })
        
        return attributesArray
    }
    
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
