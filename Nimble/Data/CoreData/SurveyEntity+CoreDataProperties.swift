//
//  SurveyEntity+CoreDataProperties.swift
//  Nimble
//
//  Created by Carlos Mario Muñoz on 8/11/23.
//
//

import Foundation
import CoreData


extension SurveyEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SurveyEntity> {
        return NSFetchRequest<SurveyEntity>(entityName: "SurveyEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var coverImageUrl: String?
    @NSManaged public var surveyType: String?
    @NSManaged public var date: Date?

}

extension SurveyEntity : Identifiable {

}
