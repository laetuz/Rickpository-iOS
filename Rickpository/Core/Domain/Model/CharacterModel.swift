//
//  CharacterModel.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import Foundation

struct CharacterModel: Equatable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
}
