//
//  NetworkingWorker.swift
//  Unsplashrimp
//
//  Created by KIHYUN SO on 2021/02/08.
//

import Foundation

protocol NetworkWorkerLogic {
  var session: URLSession { get }
  func request<T: Codable>(
    _ target: TargetType,
    type: T.Type,
    completion: @escaping (Result<T, Error>) -> Void
  )
}

extension NetworkWorkerLogic {
  var session: URLSession {
    return URLSession.shared
  }
  
  func request<T: Codable>(
    _ target: TargetType,
    type: T.Type,
    completion: @escaping (Result<T, Error>) -> Void
  ) {
    session.dataTask(with: target.request) { (data, response, error) in
      
      if let err = error {
        completion(.failure(err))
        return
      }
      
      guard let `data` = data else { return }
      
      do {
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        DispatchQueue.main.async {
          completion(.success(decodedData))
        }
      } catch let decodingError {
        completion(.failure(decodingError))
      }
      
    }.resume()
  }
}

final class NetworkWorker: BaseWorker {
  static let shared = NetworkWorker()
}

extension NetworkWorker: NetworkWorkerLogic {
  
  
}
