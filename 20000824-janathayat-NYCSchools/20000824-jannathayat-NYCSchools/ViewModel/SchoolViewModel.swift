//
//  SchoolViewModel.swift
//  20230119-janathayat-NYCSchools
//
//

import Foundation
class SchoolViewModel: NSObject {

    override init() {
        super.init()
    }
  
    func getSchoolsData(request:ApiPaths,completionHandler : @escaping(_ result: Any?, _ errorString:String?) -> Void) {
        SchoolManager.fetchSchoolList(request: request) { result, errorString in
            if result != nil{
                completionHandler(result,nil)
            }else{
                completionHandler(nil,errorString)
            }
        }
    }
    func getSATScoreData(request:ApiPaths,completionHandler : @escaping(_ result: Any?, _ errorString:String?) -> Void) {
        SchoolManager.schoolDataSATSchore(request: request) { result, errorString in
            if result != nil{
                completionHandler(result,nil)
            }else{
                completionHandler(nil,errorString)
            }
        }
    }
}
