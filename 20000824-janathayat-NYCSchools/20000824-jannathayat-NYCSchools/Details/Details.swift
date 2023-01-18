//
//  Details.swift
//  20230119-janathayat-NYCSchools
//
//

import Foundation
import UIKit

class DetailCells {

    // this function will give us the selected High school names and their average SAT scores
    //returns a UITableViewCell
    static func tableViewCellWithSATScore(_ tableView: UITableView, HSWithSatScore: NYCHighSchoolsModel) -> UITableViewCell{
        let schoolWithSATScoresCell = tableView.dequeueReusableCell(withIdentifier: DetailConstants.Cells.schoolWithSATScoreCellIdentifier) as! DetailSATScoreTableItem
        
        schoolWithSATScoresCell.hsNameLbl.text = HSWithSatScore.schoolName
        
        //For some high school, there is no information of the average SAT score, display the static mesaage to the customers
        schoolWithSATScoresCell.satReadingAvgScoreLbl.text = (HSWithSatScore.satCriticalReadingAvgScore != nil) ?  (DetailConstants.averageSATReadingScore + HSWithSatScore.satCriticalReadingAvgScore!) : DetailConstants.noSATScoreInfomationText
        
        // Sets the Math Average Score
        schoolWithSATScoresCell.satMathAvgScoreLbl.isHidden = (HSWithSatScore.satMathAvgScore != nil) ? false : true
        schoolWithSATScoresCell.satMathAvgScoreLbl.text = (HSWithSatScore.satMathAvgScore != nil) ? (DetailConstants.averageSATMathScore + HSWithSatScore.satMathAvgScore!) : nil
        
        // Sets the Writing Average Score
        schoolWithSATScoresCell.satWritingAvgScoreLbl.isHidden =  (HSWithSatScore.satWritinAvgScore != nil) ? false : true
        schoolWithSATScoresCell.satWritingAvgScoreLbl.text = (HSWithSatScore.satWritinAvgScore != nil) ? (DetailConstants.averageSATWritingScore + HSWithSatScore.satWritinAvgScore!) : nil
        
        return schoolWithSATScoresCell
    }
    
    //This function will get the selected high school's overview
    // returns a UITableViewCell
    static func tableViewCellWithOverView(_ tableView: UITableView, HSWithSatScore: NYCHighSchoolsModel) -> UITableViewCell{
        let schoolWithOverviewCell = tableView.dequeueReusableCell(withIdentifier: DetailConstants.Cells.schoolOverviewCellIdentifier) as! DetailOverViewTableItem
        
        schoolWithOverviewCell.hsOverviewLbl.text = HSWithSatScore.overviewParagraph
        
        return schoolWithOverviewCell
    }
    
    // this fucntion will get the highschool contact information with its address,phone number, and website
    //returns a UITableViewCell
    static func tableViewCellWithContactInfo(_ tableView: UITableView, HSWithSatScore: NYCHighSchoolsModel) -> UITableViewCell{
        let schoolWithContactCell = tableView.dequeueReusableCell(withIdentifier: DetailConstants.Cells.schoolWithContactCellIdentifier) as! DetailsContactTableItem
        
        schoolWithContactCell.hsAddressLbl.text = "Address: " + Utils.getCompleteAddressWithoutCoordinate(HSWithSatScore.schoolAddress)
        schoolWithContactCell.hsPhoneLbl.text = (HSWithSatScore.schoolTelephoneNumber != nil) ? "Tel:  " + HSWithSatScore.schoolTelephoneNumber! : ""
        schoolWithContactCell.hsWebsiteLbl.text = HSWithSatScore.schoolWebsite
        
        return schoolWithContactCell
    }
}
