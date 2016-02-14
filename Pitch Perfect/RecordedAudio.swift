//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Hasan Abdulhamid on 2/3/16.
//  Copyright © 2016 Hasan Abdulhamid. All rights reserved.
//

import Foundation

class RecordedAudio {
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL!, title: String!) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
    

    
}