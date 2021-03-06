//
//  DetailMealInteractor.swift
//  MealDB
//
//  Created by Lingga Kusuma Sakti on 26/10/21.
//

import Foundation
import Combine

protocol DetailMealUseCase {
    func getMealDetail() -> AnyPublisher<[Meal], Error>
    func setFavorite(meal:Meal) -> AnyPublisher<Bool, Error>
    func getFavorite() -> AnyPublisher<Meal, Error>
}

class DetailMealInteractor: DetailMealUseCase {
    
    private let repository: MealRepositoryProtocol
    private let id: String
    
    required init(repository: MealRepositoryProtocol, id: String) {
        self.repository = repository
        self.id = id
    }
    
    func getMealDetail() -> AnyPublisher<[Meal], Error> {
        return repository.getMealDetail(id: id)
    }
    
    func setFavorite(meal: Meal) -> AnyPublisher<Bool, Error> {
        return repository.setFavorite(favorite: meal)
    }
    
    func getFavorite() -> AnyPublisher<Meal, Error> {
        return repository.getFavorite(id: id)
    }
}
