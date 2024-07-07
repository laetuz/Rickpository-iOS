////
////  File.swift
////  
////
////  Created by Ryo Martin on 07/07/24.
////
//
//import Core
//import Combine
//
//public struct GetCharacterRepository<
//    CharacterLocalDataSource: LocalDataSource,
//    RemoteDataSource: DataSource,
//    Transformer: Mapper
//>: Repository where
//CharacterLocalDataSource.Request == String,
//GetCharactersLocalDataSource.Response == CharacterEntityModule,
//RemoteDataSource.Request == String,
//RemoteDataSource.Response == CharacterResponse,
//Transformer.Request == String,
//Transformer.Response == CharacterResponse,
//Transformer.Entity == CharacterEntityModule,
//Transformer.Domain == CharacterDomainModel {
//    public typealias Request = String
//    public typealias Response = CharacterDomainModel
//    
//    private let localDataSource: CharacterLocalDataSource
//    private let remoteDataSource: RemoteDataSource
//    private let mapper: Transformer
//    
//    public init(
//        localDataSource: CharacterLocalDataSource,
//        remoteDataSource: RemoteDataSource,
//        mapper: Transformer
//    ) {
//        self.localDataSource = localDataSource
//        self.remoteDataSource = remoteDataSource
//        self.mapper = mapper
//    }
//    
//    public func execute(request: String?) -> AnyPublisher<CharacterDomainModel, any Error> {
//        guard let request = request else { fatalError("Request cant be made") }
//        return self.localDataSource.get(id: request)
//    }
//    
////    public func execute(request: String?) -> AnyPublisher<CharacterDomainModel, any Error> {
////        guard let request = request else { fatalError("Request cant be made") }
////        
//////        return self.localDataSource.get(id: request)
//////            .flatMap { result -> AnyPulisher<CharacterDomainModel, Error> in
//////                if
//////            }.eraseToAnyPublisher()
////    }
//}
