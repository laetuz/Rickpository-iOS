//
//  File.swift
//  
//
//  Created by Ryo Martin on 08/07/24.
//

import Foundation
import Core
import Combine

public struct DetailGameRepository<
    RemoteData: DataSource,
    Transformer: Mapper
>: Repository where
RemoteData.Request == Any,
RemoteData.Response == CharacterResponse,
Transformer.Response == CharacterResponse,
Transformer.Domain == CharacterDomainModel {
    public typealias Request = String
    public typealias Response = CharacterDomainModel

    private let remoteDataSource: RemoteData
    private let mapper: Transformer

    public init(
        remoteDataSource: RemoteData,
        mapper: Transformer) {
            self.remoteDataSource = remoteDataSource
            self.mapper = mapper
        }

    public func execute(request: String?) -> AnyPublisher<CharacterDomainModel, Error> {
        return remoteDataSource.execute(request: nil)
            .map { mapper.transformResponseToDomain(response: $0) }
            .eraseToAnyPublisher()
    }
}
