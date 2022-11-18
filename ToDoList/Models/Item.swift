//
//  Item.swift
//  ToDoList
//
//  Created by Yuriy Gudimov on 17.11.2022.
//

import Foundation

struct Item: Encodable {
    var title: String = ""
    var done: Bool = false
}
