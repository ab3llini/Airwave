//
//  FrameElement.swift
//  Airwave
//
//  Created by Alberto Mario Bellini on 21/07/17.
//  Copyright © 2017 Alberto Mario Bellini. All rights reserved.
//

import Foundation

class IEEE80211FrameElement {
    
    public let id : IEEE80211IE
    public let len : Int
    public let data : [UInt8]
    
    init(id : IEEE80211IE, len : Int, data : [UInt8]) {
        
        self.id = id;
        self.len = len;
        self.data = data;
        
    }
    
}
