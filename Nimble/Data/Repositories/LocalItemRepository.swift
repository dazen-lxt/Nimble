//
//  LocalItemRepository.swift
//  RickMortyUIKit
//
//  Created by Carlos Mario Muñoz on 24/10/23.
//

import Foundation
import CoreData
import UIKit

class LocalItemRepository: ItemRepository {
    
    let coreDataViewContext: NSManagedObjectContext
    
    init(coreDataViewContext: NSManagedObjectContext) {
        self.coreDataViewContext = coreDataViewContext
    }
    
    func fetchItems(completion: @escaping CompletionHandler) {
        let fetchRequest: NSFetchRequest<SurveyEntity> =  SurveyEntity.fetchRequest()
        do {
            let results = try coreDataViewContext.fetch(fetchRequest)
            let repositoryResponse = results.map { SurveyModel(
                id: $0.id ?? "",
                title: $0.title ?? "",
                description: $0.desc ?? "",
                coverImageUrl: $0.coverImageUrl ?? "",
                surveyType: $0.surveyType ?? "",
                date: $0.date ?? Date()
            ) }.sorted(by: { $0.id < $1.id })
            completion(.success(repositoryResponse))
        } catch {
            completion(.failure(error))
        }
    }
    
    func saveItems(_ items: [SurveyModel]) throws {
        let fetchRequest: NSFetchRequest<SurveyEntity> = SurveyEntity.fetchRequest()
            
        do {
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
            try coreDataViewContext.execute(deleteRequest)
        } catch {
            throw error
        }

        // Limpia el contexto
        coreDataViewContext.reset()
        
        for item in items {
            let itemEntity = SurveyEntity(context: coreDataViewContext)
            itemEntity.id = item.id
            itemEntity.title = item.title
            itemEntity.desc = item.description
            itemEntity.coverImageUrl = item.coverImageUrl
            itemEntity.surveyType = item.surveyType
            itemEntity.date = item.date
        }
        do {
            try coreDataViewContext.save()
        } catch {
            throw error
        }
    }

}
