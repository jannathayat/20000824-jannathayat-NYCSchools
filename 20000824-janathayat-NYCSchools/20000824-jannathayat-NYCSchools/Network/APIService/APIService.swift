//
//  APIService.swift
//  20230119-janathayat-NYCSchools
//
//

import Foundation

class WebserviceManager {
    
    class func serviceRequest(request: ApiPaths, completionHandler : @escaping(_ result: Any?) -> Void){
        guard let highSchoolsURL = URL(string:Constants.baseURL + request.rawValue) else {
            return
        }
        let request = URLRequest(url:highSchoolsURL)
        let session = URLSession.shared
        let task = session.dataTask(with: request) {(highSchoolsData, response, error)  in
            if highSchoolsData != nil{
                do{
                    let highSchoolsObject = try JSONSerialization.jsonObject(with: highSchoolsData!, options: [])
                    completionHandler(highSchoolsObject)
                }catch{
                    print("NYC HS JSON error: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}
