//
//  ImageCell.swift
//  PresentationLayer
//
//  Created by Rhys Walden on 15/05/21.
//

import Foundation
import UIKit
import SnapKit

public class ImageCell: UITableViewCell{
    
    weak var downLoadedImageView:UIImageView!
    
    weak var authourLabel:UILabel!
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        
        downLoadedImageView = UIImageView()
            .addTo(self.contentView)
        
        downLoadedImageView.snp.makeConstraints({[unowned self] (make) in
            make.top.equalTo(self.contentView.snp.topMargin)
            make.leading.greaterThanOrEqualTo(self.contentView.snp.leadingMargin)
            make.trailing.lessThanOrEqualTo(self.contentView.snp.trailingMargin)
            make.centerX.equalTo(self.contentView.snp.centerX)
        })
        
        authourLabel = UILabel()
            .addTo(self.contentView)
        
        authourLabel.snp.makeConstraints({[unowned self] (make) in
            make.top.equalTo(self.downLoadedImageView.snp.bottomMargin)
            make.leading.equalTo(self.contentView.snp.leadingMargin)
            make.trailing.equalTo(self.contentView.snp.trailingMargin)
            make.bottom.equalTo(self.contentView.snp.bottomMargin)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
