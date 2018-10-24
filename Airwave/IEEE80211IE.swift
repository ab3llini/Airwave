//
//  ElementID.swift
//  Airwave
//
//  Created by Alberto Mario Bellini on 20/07/17.
//  Copyright © 2017 Alberto Mario Bellini. All rights reserved.
//


//Most common 802.11 element IDs
enum IEEE80211IE : UInt8 {
    
    case SSID = 0
    case SupportedRates = 1
    case FHParameterSet = 2
    case DSParameterSet = 3
    case CFParameterSet = 4
    case TIM = 5
    case IBSSParameterSet = 6
    case Country = 7
    case FHParameters = 8
    case FHPatternTable = 9
    case PowerConstraint = 32
    case ChannelSwitchAnnouncement = 37
    case Quiet = 40
    case IBSSDFS = 41
    case TPCReport = 35
    case ERPInformation = 42
    case HTCap = 45
    case HTInfo = 61
    case ExtendedSupportedRates = 50
    case RSN = 48
    case BSSLoad = 11
    case OverlappingBSSScanParameters = 74
    case EDCAParameterSet = 12
    case QoSCapability = 46
    case ExtendedCapabilities = 127
    case LastVendorSpecific = 221
    
    case Undefined = 255

    
}
