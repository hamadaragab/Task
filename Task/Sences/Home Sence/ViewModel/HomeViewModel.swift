//
//  HomeViewModel.swift
//  Task
//
//  Created by Hamada Ragab on 09/01/2023.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var products: [Results] = []
    @Published var error: String = ""
    @Published var isloading: Bool = false
    
    func getItems() {
        isloading = true
        NetworkingService.MakeRequest(type: ItemsResponse.self, url: BKConstants.GET_ITEMS, method: .GET, parameters: nil) { response in
            DispatchQueue.main.async {
                self.isloading = false
            }
            switch response {
            case .success(let responseData):
                DispatchQueue.main.async {
                    self.products = responseData.results ?? []
                }
            case .failure(let error):
                self.error = error.rawValue
            }
        }
    }
}
