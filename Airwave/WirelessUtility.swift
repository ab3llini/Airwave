//
//  WirelessUtility.swift
//  Airwave
//
//  Created by Alberto Mario Bellini on 20/07/17.
//  Copyright © 2017 Alberto Mario Bellini. All rights reserved.
//

import Cocoa
import CoreWLAN


typealias Networks = Dictionary<CWNetwork, Dictionary<IEEE80211IE, IEEE80211FrameElement>>?


enum ParseError : Error {
    
    case NilData(String)
    
}


protocol WirelessUtilityDelegate {
    
    func onScanCompleted(networks : Networks);
    func onError()
    
}

class WirelessUtility: NSObject {

    private var networks : Dictionary<CWNetwork, Dictionary<IEEE80211IE, IEEE80211FrameElement>>;
    private var delegate : WirelessUtilityDelegate!;
        
    //Constructor
    init(delegate : WirelessUtilityDelegate) {
        
        self.networks = [:]
        self.delegate = delegate
    
    }
    
    //Scan for new networks and build the cache
    public func scan() {
        
        DispatchQueue.global().async {
            
            do {
                
                let discovered : Set<CWNetwork> = try CWWiFiClient.shared().interface()!.scanForNetworks(withName: nil);
                
                for network in discovered {
                    
                    do {
                    
                        self.networks[network] = try self.parse(frame: network.informationElementData)
                                                
                    
                    }
                    catch ParseError.NilData(let description) {
                        
                        print("Unable to parse : \(description)");
                        
                    }
                }
                
                self.delegate.onScanCompleted(networks: self.networks)
                
                
            }
            catch  {
                
                self.delegate.onError();
                
            }
            
        }
        
    }
    
    //Parse a beacon/probe frame
    private func parse(frame : Data?) throws -> Dictionary<IEEE80211IE, IEEE80211FrameElement>  {
        
        if (frame == nil) {
            
            throw ParseError.NilData("Data is nil")
            
        }
        
        let body : [UInt8] = frame!.withUnsafeBytes { [UInt8](UnsafeBufferPointer(start: $0, count: frame!.count)) }
        var offset : Int = 0;
        var result : Dictionary<IEEE80211IE, IEEE80211FrameElement> = [:];
        
        while (offset < body.count) {
            
            //Parse ID && Length
            let id : IEEE80211IE = IEEE80211IE(rawValue: body[offset]) ?? IEEE80211IE.Undefined;
            let len : Int = Int(body[offset + 1]);
            var data : [UInt8] = [];
            
            for i in 0..<len {
                
                data.append(body[offset + 2 + i]);
                
            }
            
            //Append a new frame element
            result[id] = IEEE80211FrameElement(id: id, len: len, data: data);
            
            //Update offset
            offset = offset + 2 + Int(len);
            
        }
        
        return result;

        
    }
    
    
}
