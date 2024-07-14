//
//  File.swift
//  
//
//  Created by Ryo Martin on 07/07/24.
//

import Foundation
import RealmSwift
import Core

public class CharacterEntityModule: Object {
    @objc dynamic public var id: Int = 0
    @objc dynamic public var name: String = ""
    @objc dynamic public var status: String = ""
    @objc dynamic public var species: String = ""
    @objc dynamic public var gender: String = ""
    @objc dynamic public var image: String = ""
    @objc dynamic public var origin: OriginEntityModule?
    @objc dynamic public var favorite: Bool = false
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}

public class OriginEntityModule: Object, OriginEntityProtocol {
    @objc dynamic public var name: String = ""
    @objc dynamic public var url: String = ""
}

