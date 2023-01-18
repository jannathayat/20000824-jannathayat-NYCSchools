//
//  SchoolManager.swift
//  20230119-janathayat-NYCSchools
//
//

import Foundation
class SchoolManager {
    
    class func fetchSchoolList(request: ApiPaths, completionHandler : @escaping(_ result: Any?,_ errorString:String?) -> Void) {
        WebserviceManager.serviceRequest(request: request) { result in
            do {
                completionHandler(result,nil)
            } catch let err {
                print("Error Occured \(err.localizedDescription)")
                completionHandler(nil,err.localizedDescription)
            }
        }
        
    }
    class func schoolDataSATSchore(request: ApiPaths, completionHandler : @escaping(_ result: [[String:Any]]?,_ errorString:String?) -> Void) {
        WebserviceManager.serviceRequest(request: request) { result in
            do {
                let apiResponse = result as? [[String:Any]]
                completionHandler(apiResponse,nil)
            } catch let err {
                print("Error Occured \(err.localizedDescription)")
                completionHandler(nil,err.localizedDescription)
            }
        }
    }
    deinit{
        print("SchoolManager Deinited")
    }
}

