//
//  80211Decoder.swift
//  Airwave
//
//  Created by Alberto Mario Bellini on 21/07/17.
//  Copyright © 2017 Alberto Mario Bellini. All rights reserved.
//

import Foundation

typealias DecoderExpression = ([UInt8], Int) -> AnyObject


class IEEE80211Decoder {
    
    static var decoder : Dictionary<IEEE80211IE, DecoderExpression> = IEEE80211Decoder.buildCache();
    
    static func buildCache() -> Dictionary<IEEE80211IE, DecoderExpression> {
    
        var cache : Dictionary<IEEE80211IE, DecoderExpression> = [:];
        
        cache[.SSID] = IEEE80211Decoder.ssid;
        cache[.SupportedRates] = IEEE80211Decoder.supportedRates;

        return cache;
    
    }
    
    static func ssid (data : [UInt8], len : Int) -> AnyObject {
        
        return String(bytes: data, encoding: .ascii)! as AnyObject
        
    }
    
    static func supportedRates (data : [UInt8], len : Int) -> AnyObject {
        
        //Speed in Mbps && is BSS Basic Rate
        var rates : Dictionary<Float, Bool> = [:]
        
        for rate in data {
            
            var isBasicRate = false;
            
            if (rate & 0b10000000 == 0b10000000) {
                
                isBasicRate = true;
                
            }
            
            let multiplier = rate & 0b01111111;
            let speed : Float = Float(multiplier) * 500.0
            
            rates[speed] = isBasicRate;
            
        }
        
        return rates as AnyObject
        
    }
    
}
