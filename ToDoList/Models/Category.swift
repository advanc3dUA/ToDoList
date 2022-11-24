//
//  Category.swift
//  ToDoList
//
//  Created by Yuriy Gudimov on 21.11.2022.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var bgColor: String = ""
    let items = List<Item>()
}
