//
//  ErrorCell.swift
//  PresentationLayer
//
//  Created by Rhys Walden on 16/05/21.
//

import Foundation
import UIKit

public class ErrorCell: UITableViewCell{
    
    weak var label:UILabel!
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        
        label = UILabel()
            .addTo(self.contentView)
        
        label.snp.makeConstraints({[unowned self] (make) in
            make.top.equalTo(self.contentView.snp.topMargin)
            make.leading.equalTo(self.contentView.snp.leadingMargin)
            make.trailing.equalTo(self.contentView.snp.trailingMargin)
            make.bottom.equalTo(self.contentView.snp.bottomMargin)
        })
        
        label.text = "ERROR! :-("
        label.textAlignment = .center
    
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
