//
//  Router.swift
//  TestProjectDITPDRIVE
//
//  Created by Kittitat Saengthong on 3/3/2560 BE.
//  Copyright © 2560 Kittitat Saengthong. All rights reserved.
//

import Foundation
import Alamofire

enum AlamofireRouter: URLRequestConvertible {
  case getSpecies
  
  var path: String {
    switch self {
    case .getSpecies:
      return "/species"
    }
  }
  
  var method: Alamofire.HTTPMethod {
    switch self {
    case .getSpecies:
      return .get
    }
  }
  
  public var parameters: [String: Any]? {
    switch self {
    case .getSpecies:
      return nil
    }
  }
  
  func asURLRequest() throws -> URLRequest {
    let baseURLString = "https://swapi.co/api"
    let url = URL(string: baseURLString + path)!
    var mutableURLRequest = URLRequest(url: url)
    mutableURLRequest.httpMethod = method.rawValue
    
    return try Alamofire.JSONEncoding.default.encode(mutableURLRequest, with: parameters)
  }
}
