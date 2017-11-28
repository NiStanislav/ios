//
//  MusicTableViewCell.swift
//  Metronome
//
//  Created by user on 11/26/17.
//  Copyright © 2017 Stanislav Inc. All rights reserved.
//

import UIKit
import SnapKit

class MusicTableViewCell: UITableViewCell {
    let musicNoteImageView = UIImageView()
    let bpmLabel = UILabel()
    let barSizeLabel = UILabel()
    let songNameLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(musicNoteImageView)
        musicNoteImageView.image = #imageLiteral(resourceName: "note")
        musicNoteImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.height.equalToSuperview().multipliedBy(0.8)
            make.width.equalToSuperview().multipliedBy(0.1)
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        addSubview(bpmLabel)
        bpmLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(musicNoteImageView.snp.trailing).offset(10)
        }
        
        addSubview(barSizeLabel)
        barSizeLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.leading.equalTo(bpmLabel.snp.trailing).offset(10)
        }
        
        addSubview(songNameLabel)
        songNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(barSizeLabel.snp.bottom).offset(10)
            make.leading.equalTo(bpmLabel.snp.trailing).offset(10)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
