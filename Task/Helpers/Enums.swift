//
//  Enums.swift
//  Task
//
//  Created by Hamada Ragab on 09/01/2023.
//

import Foundation

enum ErrorStatus: String, Error {
    case NoInternet = "No Internet Connection"
    case InvalidUrl = "The Requested Url Is Invalid"
    case ValidationError = "Validation Error"
    case UnexpectedError = "Unexpected Error Please try again Later"
    case ParsingError = "Error When Parsing Data"

}


enum HttpMethod: String {
    case POST = "Post"
    case GET = "Get"
    case DELETE = "Delete"
    case PUT = "Put"

}
