//
//  NetworkTable.swift
//  Airwave
//
//  Created by Alberto Mario Bellini on 11/08/17.
//  Copyright © 2017 Alberto Mario Bellini. All rights reserved.
//

import Cocoa

enum NetworkProperty : String {
    
    case SSID = "ssid"
    case BSSID = "bssid"
    case VENDOR = "vendor"
    case RSSI = "rssi"
    case Channel = "channel"
    
}

typealias CellExpression = (Int) -> NSTableCellView

class CellFactory {
    
    /*private static func simpleFactory(text : String) -> NSTableCellView {
        
        
        
    }
    
    public static func ssidCell (index : Int) -> NSTableCellView {
        
        
        
    }*/
    
}

class NetworkTable: NSTableView, NSTableViewDataSource, NSTableViewDelegate {
    
    private var networks : Networks = nil

    override func awakeFromNib() {
        
        self.dataSource = self
        self.delegate = self
                
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        
        if (self.networks != nil) {
            
            return self.networks!.count
            
        }
        else {
            
            return 0;
        }
        
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let current = Array(self.networks!.keys)[row];
        let cell = tableView.make(withIdentifier: "cell", owner: self) as! NetworkCellView
        
        return cell;
    }
    

    
    func setData(networks: Networks) {
        
        self.networks = networks
        self.reloadData()
        
    }
    
}
