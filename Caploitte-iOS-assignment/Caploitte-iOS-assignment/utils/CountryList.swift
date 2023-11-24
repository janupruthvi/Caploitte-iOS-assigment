//
//  CountryList.swift
//  Caploitte-iOS-assignment
//
//  Created by itelasoft on 2023-11-23.
//

import Foundation

enum Country: String, CaseIterable {
    case ae = "ae"
    case ar = "ar"
    case at = "at"
    case au = "au"
    case be = "be"
    case bg = "bg"
    case br = "br"
    case ca = "ca"
    case ch = "ch"
    case cn = "cn"
    case co = "co"
    case cu = "cu"
    case cz = "cz"
    case de = "de"
    case eg = "eg"
    case fr = "fr"
    case gb = "gb"
    case gr = "gr"
    case hk = "hk"
    case hu = "hu"
    case id = "id"
    case ie = "ie"
    case il = "il"
    case IN = "in"
    case it = "it"
    case jp = "jp"
    case kr = "kr"
    case lt = "lt"
    case lv = "lv"
    case ma = "ma"
    case mx = "mx"
    case my = "my"
    case ng = "ng"
    case nl = "nl"
    case no = "no"
    case nz = "nz"
    case ph = "ph"
    case pl = "pl"
    case pt = "pt"
    case ro = "ro"
    case rs = "rs"
    case ru = "ru"
    case sa = "sa"
    case se = "se"
    case sg = "sg"
    case si = "si"
    case sk = "sk"
    case sl = "sl"
    case th = "th"
    case tr = "tr"
    case tw = "tw"
    case ua = "ua"
    case us = "us"
    case ve = "ve"
    case za = "za"
}

extension Country: CustomStringConvertible {
    public var description: String {
        switch self {
        case .ae:
            return "United Arab Emirates"
        case .ar:
            return "Argentina"
        case .at:
            return "Austria"
        case .au:
            return "Australia"
        case .be:
            return "Belgium"
        case .bg:
            return "Bulgaria"
        case .br:
            return "Brazil"
        case .ca:
            return "Canada"
        case .ch:
            return "Switzerland"
        case .cn:
            return "China"
        case .co:
            return "Colombia"
        case .cu:
            return "Cuba"
        case .cz:
            return "Czechia"
        case .de:
            return "Germany"
        case .eg:
            return "Egypt"
        case .fr:
            return "France"
        case .gb:
            return "United Kingdom"
        case .gr:
            return "Greece"
        case .hk:
            return "Hong Kong"
        case .hu:
            return "Hungary"
        case .id:
            return "Indonesia"
        case .ie:
            return "Ireland"
        case .il:
            return "Israel"
        case .IN:
            return "India"
        case .it:
            return "Italy"
        case .jp:
            return "Japan"
        case .kr:
            return "South Korea"
        case .lt:
            return "Lithuania"
        case .lv:
            return "Latvia"
        case .ma:
            return "Morocco"
        case .mx:
            return "Mexico"
        case .my:
            return "Malaysia"
        case .ng:
            return "Nigeria"
        case .nl:
            return "Netherlands"
        case .no:
            return "Norway"
        case .nz:
            return "New Zealand"
        case .ph:
            return "Philippines"
        case .pl:
            return "Poland"
        case .pt:
            return "Portugal"
        case .ro:
            return "Romania"
        case .rs:
            return "Serbia"
        case .ru:
            return "Russia"
        case .sa:
            return "South Africa"
        case .se:
            return "Sweden"
        case .sg:
            return "Singapore"
        case .si:
            return "Slovenia"
        case .sk:
            return "Slovakia"
        case .sl:
            return "SriLanka"
        case .th:
            return "Thailand"
        case .tr:
            return "Türkiye"
        case .tw:
            return "Taiwan"
        case .ua:
            return "Ukraine"
        case .us:
            return "United States"
        case .ve:
            return "Venezuela"
        case .za:
            return "South Africa"
        }
    }
}
