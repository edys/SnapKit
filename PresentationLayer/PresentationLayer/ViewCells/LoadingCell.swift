//
//  LoadingCell.swift
//  PresentationLayer
//
//  Created by Rhys Walden on 15/05/21.
//

import Foundation
import UIKit
import SnapKit

public class LoadingCell: UITableViewCell{
    
    public weak var progress:UIActivityIndicatorView!
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        
        progress = UIActivityIndicatorView()
            .addTo(self.contentView)
        
        progress.snp.makeConstraints({[unowned self] (make) in
            make.top.equalTo(self.contentView.snp.topMargin)
            make.leading.equalTo(self.contentView.snp.leadingMargin)
            make.trailing.equalTo(self.contentView.snp.trailingMargin)
            make.bottom.equalTo(self.contentView.snp.bottomMargin)
        })
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func prepareForReuse() {
        progress.startAnimating()
    }
}
