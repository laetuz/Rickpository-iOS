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
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
