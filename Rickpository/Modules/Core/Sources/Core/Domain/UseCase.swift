//
//  File.swift
//  
//
//  Created by Ryo Martin on 07/07/24.
//

import Combine

public protocol UseCase {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
