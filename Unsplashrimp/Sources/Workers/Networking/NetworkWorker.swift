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
  
  func willSend(_ target: TargetType)
  func didRecive(_ response: URLResponse?)
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
    willSend(target)
    
    session.dataTask(with: target.request) { (data, response, error) in
      
      didRecive(response)
      
      if let err = error {
        Log.error(err.localizedDescription)
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
  
  func willSend(_ target: TargetType) {
    Log.info(" Request  \(target)")
  }
  
  func didRecive(_ response: URLResponse?) {
    if let statusCode = (response as? HTTPURLResponse)?.statusCode {
      Log.info("Response \(statusCode)")
    }
  }
}

final class NetworkWorker: BaseWorker {
  static let shared = NetworkWorker()
}

extension NetworkWorker: NetworkWorkerLogic {
  
  
}
