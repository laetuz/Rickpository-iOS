//
//  File.swift
//  
//
//  Created by Ryo Martin on 07/07/24.
//

import Foundation

public protocol Mapper {
    associatedtype Request
    associatedtype Response
    associatedtype Entity
    associatedtype Domain
    
    func transformResponseToEntity(response: Response) -> Entity
    func transformEntityToDomain(entity: Entity) -> Domain
}
