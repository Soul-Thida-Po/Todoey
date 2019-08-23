//
//  Category.swift
//  Todoey
//
//  Created by Soulthidapo on 2019/08/22.
//  Copyright © 2019 Soul. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object{
    @objc dynamic var name: String = ""
    @objc dynamic var colour: String = ""
    let items = List<Item>()
}
