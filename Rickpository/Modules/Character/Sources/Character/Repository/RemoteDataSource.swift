//
//  RemoteDataSource.swift
//  Rickpository
//
//  Created by Ryo Martin on 01/07/24.
//

import Foundation
import Alamofire
import Combine
import Core

public protocol RemoteDataSourceProtocol: AnyObject {

  func getCharacters() -> AnyPublisher<[CharacterResponse], Error>

}

public final class RemoteDataSource: NSObject {

  override init() { }

  public static let sharedInstance: RemoteDataSource =  RemoteDataSource()

}

extension RemoteDataSource: RemoteDataSourceProtocol {

    public func getCharacters() -> AnyPublisher<[CharacterResponse], Error> {
    return Future<[CharacterResponse], Error> { completion in
        if let url = URL(string: Endpoints.Gets.characters.url) {
        AF.request(url)
          .validate()
          .responseDecodable(of: CharactersResponse.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value.results))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
}
