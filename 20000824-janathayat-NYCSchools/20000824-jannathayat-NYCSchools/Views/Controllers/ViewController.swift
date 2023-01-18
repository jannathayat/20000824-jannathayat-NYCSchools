//
//  ViewController.swift
//  20230119-janathayat-NYCSchools
//
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var nycHSList: [NYCHighSchoolsModel]?
    var viewModel:SchoolViewModel = SchoolViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.startAnimating()
        fetchSchoolData()
    }
    private func fetchSchoolData(){
        self.viewModel.getSchoolsData(request: .listOfSchools) { result, errorString in
            if result != nil{
                self.nycHSList = Utils.fetchNYCHsWithJsonData(result as Any)
                self.fetchSATScore()
            }else{
                print("errorString = \(errorString ?? "")")
            }
        }
    }
    private func fetchSATScore(){
        self.viewModel.getSATScoreData(request: .schoolDataSATScore) { result, errorString in
            if result != nil{
                self.addSatScoreToHighSchool(result as Any)
                DispatchQueue.main.async {[weak self] in
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                    self?.tableView.reloadData()
                }
            }else{
                print("errorString = \(errorString ?? "")")
            }
        }
    }
    
    // This function is used to add the SAT score to the high school
    // the parameter satScoreObjecr: Data of array composed with dictionary
    private func addSatScoreToHighSchool(_ satScoreObject: Any){
        guard let highSchoolsWithSatScoreArr = satScoreObject as? [[String: Any]] else{
            return
        }
        
        for  highSchoolsWithSatScore in highSchoolsWithSatScoreArr{
            if let matchedDBN = highSchoolsWithSatScore["dbn"] as? String{
                //This will get the High School with the Common DBN
                let matchedHighSchools = self.nycHSList?.first(where: { (nycHighSchool) -> Bool in
                    return nycHighSchool.dbn == matchedDBN
                })
                
                guard matchedHighSchools != nil else{
                    continue
                }
                
                if let satReadingScoreObject =  highSchoolsWithSatScore["sat_critical_reading_avg_score"] as? String{
                    matchedHighSchools!.satCriticalReadingAvgScore = satReadingScoreObject
                }
                
                if let satMathScoreObject = highSchoolsWithSatScore["sat_math_avg_score"] as? String{
                    matchedHighSchools!.satMathAvgScore = satMathScoreObject
                }
                
                if let satWritingScoreObject =  highSchoolsWithSatScore["sat_writing_avg_score"] as? String{
                    matchedHighSchools!.satWritinAvgScore = satWritingScoreObject
                }
                
            }
        }
    }
}

// UITableViewDataSource and UITableViewDelegate extensions
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nycHSList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ShowDataShowTableitem = self.tableView.dequeueReusableCell(withIdentifier: "ShowDataShowTableitem", for: indexPath) as! ShowDataShowTableitem
        
        tableView.rowHeight = 195
        
        var nycHighSchoolList: NYCHighSchoolsModel
        nycHighSchoolList = self.nycHSList![indexPath.row]
        
        if let schoolName = nycHighSchoolList.schoolName {
            cell.schoolNameLbl.text = schoolName
        }
        
        if let schoolAddr = nycHighSchoolList.schoolAddress {
            let address = Utils.getCompleteAddressWithoutCoordinate(schoolAddr)
            cell.schoolAddrLbl.text = "Address: \(address)"
            
        }
        return cell
    }

    // UITableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SchoolDetailsVC") as? SchoolDetailsVC
        vc?.HSWithSatScore =   self.nycHSList![indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
