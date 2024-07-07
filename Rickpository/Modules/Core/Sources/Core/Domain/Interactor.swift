//
//  File.swift
//  
//
//  Created by Ryo Martin on 07/07/24.
//

import Foundation
import Combine

public struct Interactor<Request, Response, R: Repository>: UseCase
where R.Request == Request, R.Response == Response {
    
    private let _repository: R
    
    public init(repository: R) {
        _repository = repository
    }
    
    public func execute(request: Request?) -> AnyPublisher<Response, any Error> {
        _repository.execute(request: request)
    }
    
    
}
