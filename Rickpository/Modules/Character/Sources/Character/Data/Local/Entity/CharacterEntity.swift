//
//  File.swift
//  
//
//  Created by Ryo Martin on 07/07/24.
//

import Foundation
import RealmSwift
import Core

public class CharacterEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var status: String = ""
    @objc dynamic var species: String = ""
    @objc dynamic var gender: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var origin: OriginEntity?
    @objc dynamic var favorite: Bool = false
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}

public class OriginEntity: Object, OriginEntityProtocol {
    @objc dynamic public var name: String = ""
    @objc dynamic public var url: String = ""
}

