//
//  itemstore.swift
//  Homeowner
//
//  Created by Amrit Kaur on 2019-10-25.
//  Copyright © 2019 Amrit Kaur. All rights reserved.
//

import UIKit
class ItemStore {
    var allItems = [Item]()
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    init() {
        for _ in 0..<5 {
            createItem()
        }
    }
}
