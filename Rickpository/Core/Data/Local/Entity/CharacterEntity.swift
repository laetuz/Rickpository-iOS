//
//  CharacterEntity.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import Foundation
import RealmSwift

class CharacterEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var status: String = ""
    @objc dynamic var species: String = ""
    @objc dynamic var gender: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var origin: OriginEntity?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class OriginEntity: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var url: String = ""
}
