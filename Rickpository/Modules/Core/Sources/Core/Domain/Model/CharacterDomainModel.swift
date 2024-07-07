//
//  File.swift
//  
//
//  Created by Ryo Martin on 07/07/24.
//

import Foundation

public protocol OriginEntityProtocol {
    var name: String { get }
    var url: String { get }
}

public struct CharacterDomainModel: Equatable, Identifiable {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let gender: String
    public let image: String
    public let origin: Origin
    public let favorite: Bool
    
    public struct Origin: Equatable {
        public let name: String
        public let url: String
    }
    
    public init(id: Int, name: String, status: String, species: String, gender: String, image: String, origin: OriginEntityProtocol, favorite: Bool) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.gender = gender
        self.image = image
        self.origin = Origin(name: origin.name, url: origin.url) //origin.map { Origin(name: $0.name, url: $0.url)}
        self.favorite = favorite
    }
}
