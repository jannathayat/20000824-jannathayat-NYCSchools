//
//  Utils.swift
//  20230119-janathayat-NYCSchools
//
//  Created by Muhammad Haris Butt on 18/01/2023.
//

import Foundation

enum baseURLs:String{
    case development = "https://data.cityofnewyork.us/resource/"
}
struct Constants {
    static let baseURL = baseURLs.development.rawValue
}

enum ApiPaths:String{
    case listOfSchools = "s3k6-pzi2.json" // 1
    case schoolDataSATScore = "f9bf-2cp4.json"
    }

struct DetailConstants {
    struct Cells {
        static let schoolWithSATScoreCellIdentifier =  "DetailSATScoreTableItem"
        static let schoolOverviewCellIdentifier = "DetailOverViewTableItem"
        static let schoolWithAddressCellIdentifier = "DetailAddressTableItem"
        static let schoolWithContactCellIdentifier = "DetailsContactTableItem"
    }

    static let noSATScoreInfomationText = "There is no SAT score information for this high school"
    static let averageSATReadingScore = "SAT Average Critical Reading Score:  "
    static let averageSATMathScore = "SAT Average Math Score:   "
    static let averageSATWritingScore = "SAT Average Writing Score:   "
}

class Utils {
    // this function will help us fetch the address without needing the coodinates
    // this will return a string, address of the highschool
    static func getCompleteAddressWithoutCoordinate(_ schoolAddr: String?) -> String{
        if let schoolAddress = schoolAddr{
            let address = schoolAddress.components(separatedBy: "(")
            return address[0]
        }
        return ""
    }
    
    // this function will be used to fetch JSON payload and will assign parameters to the NYCHS model
    // the parameters being dictionary with school detail
    // the results will be Highschool model type
    static func getHSInfoWithJSON(_ json: [String: Any]) -> NYCHighSchoolsModel?{
        if !json.isEmpty{
            let nycHighSchools = NYCHighSchoolsModel()
            if let dbnObject = json["dbn"] as? String{
                nycHighSchools.dbn = dbnObject
            }
            
            if let schoolNameOnject = json["school_name"] as? String{
                nycHighSchools.schoolName = schoolNameOnject
            }
            
            if let overviewParagraphObject = json["overview_paragraph"] as? String{
                nycHighSchools.overviewParagraph = overviewParagraphObject
            }
            if let schoolAddressObject = json["location"] as? String{
                nycHighSchools.schoolAddress = schoolAddressObject
            }
            if let schoolTelObject = json["phone_number"] as? String{
                nycHighSchools.schoolTelephoneNumber = schoolTelObject
            }
            
            if let websiteObject = json["website"] as? String{
                nycHighSchools.schoolWebsite = websiteObject
            }
            
            return nycHighSchools
        }
        return nil
    }
    
    //Pass the JSON and configure to the model type
    // the parameter is highschoolData, the data is of array composed with dictionary
    // it wil return array of model class
    static func fetchNYCHsWithJsonData(_ highSchoolsData: Any) -> [NYCHighSchoolsModel]?{
        guard let highSchoolsDictionaryArray = highSchoolsData as? [[String: Any]] else{
            return nil
        }
        var highSchoolModelArray = [NYCHighSchoolsModel]()
        for highSchoolsDictionary in highSchoolsDictionaryArray{
            if let highSchoolModels = Utils.getHSInfoWithJSON(highSchoolsDictionary){
                highSchoolModelArray.append(highSchoolModels)
            }
        }
        return highSchoolModelArray
    }
    
}
