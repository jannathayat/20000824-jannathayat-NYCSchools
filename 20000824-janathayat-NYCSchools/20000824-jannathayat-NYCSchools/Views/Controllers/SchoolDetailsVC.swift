//
//  SchoolDetailsVC.swift
//  20230119-janathayat-NYCSchools
//
//

import UIKit


class SchoolDetailsVC: UITableViewController {
    
    var HSWithSatScore: NYCHighSchoolsModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = HSWithSatScore.schoolName
        self.tableView.rowHeight = UITableView.automaticDimension
    }
}

extension SchoolDetailsVC {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return DetailCells.tableViewCellWithSATScore(self.tableView, HSWithSatScore: self.HSWithSatScore)
        case 1:
            return DetailCells.tableViewCellWithOverView(self.tableView, HSWithSatScore: self.HSWithSatScore)
        case 2:
            return DetailCells.tableViewCellWithContactInfo(self.tableView, HSWithSatScore: self.HSWithSatScore)
        default:
        return UITableViewCell()
        }
    }
    
    // UITable View Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0,1,2:
            return UITableView.automaticDimension
        default:
          return 0
        }
    }
}
