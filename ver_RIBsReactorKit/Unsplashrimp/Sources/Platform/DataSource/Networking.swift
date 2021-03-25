//
//  Networking.swift
//  Unsplashrimp
//
//  Created by Stat on 2021/03/25.
//

import Alamofire
import Moya
import RxMoya
import RxSwift

final class Networking<Target: TargetType>: MoyaProvider<Target> {
  
  func request(
    _ target: Target,
    withRetry needRetry: Bool = true,
    retryCount: Int = 3,
    file: String = #file,
    function: String = #function,
    line: UInt = #line
  ) -> Single<Response> {
    #if DEBUG
    let requestString = "\(target.method.rawValue) \(target.path)"
    let request = self.rx.request(target)
      .filterSuccessfulStatusCodes()
      .do(
        onSuccess: { response in
          let message = "SUCCESS: \(requestString) (\(response.description))"
          Log.debug(message)
        }, onError: { [weak self] error in
          var message = "FAILURE: \(requestString)"
          guard let this = self else {
            Log.warning(message)
            Log.warning(error)
            return
          }
          
          let afError = this.loggingAFError(message: message, error: error)
          message = afError.message
          
          let isLoggingMoyaError = this.isLoggingMoyaError(
            file: file,
            function: function,
            line: line,
            hasStatusCode: afError.hasStatusCode,
            message: message,
            error: error
          )
          
          if !isLoggingMoyaError {
            Log.warning(message)
            Log.warning(error)
          }
        }, onSubscribed: {
          let message = "REQUEST: \(requestString)"
          Log.debug(message)
        }
      )

    if needRetry {
      return request.retry(retryCount, delay: .exponential(initial: 1.5, multiplier: 2))
    } else {
      return request
    }

    #else
    if needRetry {
      return rx.request(target).retry(retryCount, delay: .exponential(initial: 1.5, multiplier: 2))
    } else {
      return rx.request(target)
    }
    #endif
  }
  
  private func loggingAFError(
    message: String,
    error: Error
  ) -> (message: String, hasStatusCode: Bool)  {
    var hasStatusCode: Bool = false
    guard let afError = error.asAFError else { return (message, hasStatusCode) }
    var message = message
    
    if let responseCode = afError.responseCode {
      message += " Status Code: \(responseCode)"
      hasStatusCode = true
    }
    if let failureReason = afError.failureReason {
      message += "\nFailure Reason: \(failureReason)"
    }
    if let recoverySuggestion = afError.recoverySuggestion {
      message += "\nRecovery Suggestion: \(recoverySuggestion)"
    }
    if let contentType = afError.responseContentType {
      message += "\nContent Type: \(contentType)"
    }
    if let errorDescription = afError.errorDescription {
      message += "\nDescription: \(errorDescription)"
    }
    
    message += "\n\(afError.localizedDescription)"
    
    return (message, hasStatusCode)
  }
  
  private func isLoggingMoyaError(
    file: String,
    function: String,
    line: UInt,
    hasStatusCode: Bool,
    message: String,
    error: Error
  ) -> Bool {
    guard let moyaError = error as? MoyaError, let response = moyaError.response else { return false }
    
    var message = message
    
    if !hasStatusCode {
      message += " \(response.description)"
    }
    
    if let jsonObject = try? response.mapJSON(failsOnEmptyData: false) {
      Log.warning(message)
      Log.warning(jsonObject)
    } else {
      let rawString = String(data: response.data, encoding: .utf8) ?? ""
      Log.warning(message)
      Log.warning(rawString)
    }
    
    return true
  }
}
