//
//  Song.swift
//  Metronome
//
//  Created by user on 24.11.17.
//  Copyright © 2017 Stanislav Inc. All rights reserved.
//

import Foundation
import SwiftyJSON

class Song {
    let name : String
    let bpm : Int
    let numOfSound : Int
    let barSize : Int
    init(dict : [String:Any]){
        self.name = dict["name"] as! String
        self.bpm = dict["bpm"] as! Int
        self.numOfSound = dict["numOfSound"] as! Int
        self.barSize = dict["barSize"] as! Int
    }
    
    init(name : String, bpm : Int, numOfSound : Int, barSize : Int) {
        self.bpm = bpm
        self.name = name
        self.numOfSound = numOfSound
        self.barSize = barSize
    }
}
