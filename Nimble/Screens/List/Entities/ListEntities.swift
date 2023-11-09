//
//  ListEntities.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 7/11/23.
//

import Foundation


struct SurveyModel {
    var id: String
    var title: String
    var description: String
    var coverImageUrl: String
    var surveyType: String
    var date: Date
}

struct SurveyViewModel {
    var title: String
    var description: String
    var coverImageUrl: String
    var surveyType: String
    var date: String
}
