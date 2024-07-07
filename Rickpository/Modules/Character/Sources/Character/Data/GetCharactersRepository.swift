//
//  File.swift
//  
//
//  Created by Ryo Martin on 07/07/24.
//

import Core
import Combine

public struct GetCharactersRepository<
    CharacterLocalDataSource: LocalDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper
>: Repository where
CharacterLocalDataSource.Response == CharacterEntityModule,
RemoteDataSource.Response == [CharacterResponse],
Transformer.Entity == [CharacterEntityModule],
Transformer.Domain == [CharacterDomainModel] {
    
    public typealias Request = Any
    public typealias Response = [CharacterDomainModel]
    
    private let localDataSource: CharacterLocalDataSource
    private let remoteDataSource: RemoteDataSource
    private let mapper: Transformer
    
    public init(
        localDataSource: CharacterLocalDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer
    ) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
        self.mapper = mapper
    }
    
    public func execute(request: Request?) -> AnyPublisher<[Core.CharacterDomainModel], any Error> {
        return self.localDataSource.list(request: nil)
          .flatMap { result -> AnyPublisher<[CharacterDomainModel], Error> in
            if result.isEmpty {
              return self.remoteDataSource.execute(request: nil)
                    .map { self.mapper.transformResponseToEntity(response: $0 as! Transformer.Response) }
                .catch { _ in self.localDataSource.list(request: nil) }
                .flatMap { self.localDataSource.add(entities: $0) }
                .filter { $0 }
                .flatMap { _ in self.localDataSource.list(request: nil)
                    .map { self.mapper.transformEntityToDomain(entity: $0) }
                }
                .eraseToAnyPublisher()
            } else {
              return self.localDataSource.list(request: nil)
                .map { self.mapper.transformEntityToDomain(entity: $0) }
                .eraseToAnyPublisher()
            }
          }.eraseToAnyPublisher()
    }
}
