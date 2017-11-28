//
//  SongManager.swift
//  Metronome
//
//  Created by user on 24.11.17.
//  Copyright © 2017 Stanislav Inc. All rights reserved.
//

import Alamofire
import SwiftyJSON
class SongManager {
    var songs : [Song] = []
    static let shared = SongManager()
    private init() {
    }
    
    func getSongs(completion: @escaping([Song]) -> Void) {
        Alamofire.request("https://jsonblob.com/api/75158a69-d10f-11e7-80ac-835685f23e58").validate().responseJSON { (response) in
            guard let json = response.result.value as? [String:Any] else { return }
            print(json)
            let tmp : [Any] = json["songs"] as! [Any]
            for i in tmp {
                self.songs.append(Song(dict: i as! [String: Any]))
            }
            completion(self.songs)
        }
    }
    
    
}
