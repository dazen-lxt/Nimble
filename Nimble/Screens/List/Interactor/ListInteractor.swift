//
//  ListInteractor.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 7/11/23.
//

import Foundation


final class ListInteractor: ListDataSource {
    
    let localRepository: ItemRepository
    let remoteRepository: ItemRepository
    var presenter: ListPresentationLogic?
    var model: [SurveyModel] = []
    var itemSelected: SurveyModel?
    
    init(localRepository: ItemRepository, remoteRepository: ItemRepository) {
        self.localRepository = localRepository
        self.remoteRepository = remoteRepository
    }
    
    private func fetchRemoteData() {
        remoteRepository.fetchItems() { [unowned self] repositoryResponse in
            switch(repositoryResponse) {
            case .success(let data):
                self.model = data
                presenter?.presentResult(items: self.model)
                try? self.localRepository.saveItems(data)
            default:
                self.fetchLocalData()
            }
        }
    }
    
    private func fetchLocalData() {
        localRepository.fetchItems() { [unowned self] repositoryResponse in
            switch(repositoryResponse) {
            case .success(let data):
                self.model = data
                presenter?.presentResult(items: self.model)
            default:
                break
            }
        }
    }
}

extension ListInteractor: ListBusinessLogic {
    
    func selectModel(index: Int) {
        itemSelected = model[index]
    }
    
    func fetchList() {
        fetchRemoteData()
    }
}
