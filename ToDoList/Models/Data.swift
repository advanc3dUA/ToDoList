//
//  Data.swift
//  ToDoList
//
//  Created by Yuriy Gudimov on 20.11.2022.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}
