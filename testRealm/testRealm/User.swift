//
//  User.swift
//  testRealm
//
//  Created by 阪田竜生 on 2022/12/26.
//

import Foundation

import RealmSwift

class User: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
}

class Point: Object{
    @objc dynamic var x = 0.0
    @objc dynamic var y = 0.0
}
