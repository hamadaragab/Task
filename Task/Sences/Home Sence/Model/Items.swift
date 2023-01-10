//
//  Items.swift
//  Task
//
//  Created by Hamada Ragab on 09/01/2023.
//

import Foundation
struct ItemsResponse : Codable {
    var results : [Results]?
    var pagination : Pagination?

    enum CodingKeys: String, CodingKey {

        case results = "results"
        case pagination = "pagination"
    }
   
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = try values.decodeIfPresent([Results].self, forKey: .results)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
    }
  

}
