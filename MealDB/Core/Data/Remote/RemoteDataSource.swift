//
//  MealRepository.swift
//  MealDB
//
//  Created by Lingga Kusuma Sakti on 19/10/21.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol {
    func getCategories() -> AnyPublisher<[CategoryResponse], Error>
}

final class RemoteDataSource {
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getCategories() -> AnyPublisher<[CategoryResponse], Error> {
        return Future<[CategoryResponse], Error> { completion in
            if let url = URL(string: Endpoints.Gets.categories.url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: CategoriesResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.categories))
                        case .failure:
                            completion(.failure(URLError.invalidEmptyResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}