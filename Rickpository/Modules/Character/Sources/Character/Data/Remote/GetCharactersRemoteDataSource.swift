//
//  File.swift
//  
//
//  Created by Ryo Martin on 07/07/24.
//

import Core
import Combine
import Alamofire
import Foundation

public struct GetCharactersRemoteDataSource : DataSource {
  public typealias Request = Any

  public typealias Response = [CharacterResponse]

  private let _endpoint: String

  public init(endpoint: String) {
    _endpoint = endpoint
  }

  public func execute(request: Any?) -> AnyPublisher<[CharacterResponse], Error> {
    return Future<[CharacterResponse], Error> { completion in
      if let url = URL(string: _endpoint) {
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
