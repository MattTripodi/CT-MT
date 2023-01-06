//
//  DiscoverListTableViewCell.swift
//  CT-MT
//
//  Created by Matthew Tripodi on 11/7/22.
//

import UIKit
import SDWebImage

class DiscoverListTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var discoverCollectionView: UICollectionView!
    @IBOutlet weak var shadowView: UIView!
    var discoverData = [[String:Any]]()
    @objc public var isBannerCell : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func setDataForDiscocverList (dataArray : [[String:Any]]){
        discoverData = dataArray
        discoverCollectionView.dataSource = self
        discoverCollectionView.delegate = self
        discoverCollectionView.reloadData()
    }
    @objc func setDataForBannerList (dataArray : [[String:Any]]){
        discoverData = dataArray
        discoverCollectionView.dataSource = self
        discoverCollectionView.delegate = self
        discoverCollectionView.reloadData()
    }
}

extension DiscoverListTableViewCell : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return discoverData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(isBannerCell){
            let bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as! BannerCollectionViewCell
            bannerCell.bannerImageView.sd_setImage(with: URL(string: discoverData[indexPath.row]["image"]! as? String ?? ""), completed: nil)
            bannerCell.bannerImageView.contentMode = .scaleToFill
            bannerCell.shadowView.layer.shadowColor = UIColor.black.cgColor
            bannerCell.shadowView.layer.shadowOpacity = 0.1
            bannerCell.shadowView.layer.shadowOffset = CGSize.zero
            bannerCell.shadowView.layer.shadowRadius = 2
            bannerCell.bannerImageView.layer.cornerRadius = 5;
            bannerCell.bannerImageView.clipsToBounds = true
            bannerCell.shadowView.layer.cornerRadius = 5;
            return bannerCell
        }
        else{
            let discoverCell = collectionView.dequeueReusableCell(withReuseIdentifier: "discoverListCollCell", for: indexPath) as! DiscoverListCollectionViewCell
            var stringImageURL  = discoverData[indexPath.row]["images"] as! String
            stringImageURL = String(stringImageURL.filter { !"\n".contains($0) })
            discoverCell.discoverImageView.sd_setImage(with: URL(string: stringImageURL), completed: nil)
            discoverCell.discoverImageView.contentMode = .scaleAspectFill
            discoverCell.discoverImageView.clipsToBounds = true
            //discoverCell.discoverImageView.layer.cornerRadius = 5
            var textStr = discoverData[indexPath.row]["heading"] as? String ?? ""
            textStr = textStr.capitalized
            let subHeading = " \(discoverData[indexPath.row]["sub_heading"] as? String ?? "")"
            let tempStr : NSMutableAttributedString = NSMutableAttributedString(string: textStr, attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 12)])
            tempStr.append(NSAttributedString(string: subHeading, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 10)]))
            discoverCell.discoverTextLabel.attributedText = tempStr
            discoverCell.imageBackgroundView.layer.shadowColor = UIColor.black.cgColor
            discoverCell.imageBackgroundView.layer.shadowOpacity = 0.1
            discoverCell.imageBackgroundView.layer.shadowOffset = CGSize.zero
            discoverCell.imageBackgroundView.layer.shadowRadius = 2
            //discoverCell.imageBackgroundView.layer.cornerRadius = 5
            
            return discoverCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(isBannerCell){
            return CGSize(width: 300, height:155) //290,150
        }
        else{
            return CGSize(width: 155, height:195)//135
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0 //5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: -10, left: 5, bottom: -10, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(isBannerCell){
        }
        else{

        }
    }
}
