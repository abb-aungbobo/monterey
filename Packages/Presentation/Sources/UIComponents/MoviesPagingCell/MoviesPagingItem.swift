//
//  MoviesPagingItem.swift
//  
//
//  Created by Aung Bo Bo on 28/04/2024.
//

import Parchment

struct MoviesPagingItem: PagingItem, Hashable {
    let title: String?
    let index: Int
    
    func isBefore(item: any PagingItem) -> Bool {
        if let item = item as? PagingIndexItem {
            return index < item.index
        } else if let item = item as? Self {
            return index < item.index
        } else {
            return false
        }
    }
}
