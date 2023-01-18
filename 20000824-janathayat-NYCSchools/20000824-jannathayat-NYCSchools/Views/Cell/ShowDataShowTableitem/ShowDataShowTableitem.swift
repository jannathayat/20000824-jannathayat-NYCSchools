//
//  ShowDataShowTableitem.swift
//  20230119-janathayat-NYCSchools
//
//

import UIKit


class ShowDataShowTableitem: UITableViewCell {

    // MARK: IBOutlet
    @IBOutlet var cardView: UIView!
    @IBOutlet var sideBarView: UIView!
    @IBOutlet var schoolNameLbl: UILabel!
    @IBOutlet var schoolAddrLbl: UILabel!
    @IBOutlet var schoolPhoneNumBtn: UIButton!
    @IBOutlet var navigateToAddrBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCardViewShadows()
    }

    func setupCardViewShadows(){
        let view = cardView
        view?.layer.cornerRadius = 15.0
        view?.layer.shadowColor = UIColor.black.cgColor
        view?.layer.shadowOffset = CGSize(width: 0, height: 2)
        view?.layer.shadowOpacity = 0.8
        view?.layer.shadowRadius = 3
        view?.layer.masksToBounds = false
    }
}
