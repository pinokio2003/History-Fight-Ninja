//
//  MapModel.swift
//  testMap
//
//  Created by Anatolii Kravchuk on 30.04.2024.
//

import Foundation
import SwiftUI

enum MapCountryColor {
    case grey
    case green
    case red
    
    func toSwiftUIColor() -> Color {
        switch self {
        case .grey:
            return .gray
        case .green:
            return .green
        case .red:
            return .red
        }
    }
}

class MapCountryModel: Identifiable, ObservableObject {
    let id = UUID()
    let countryCode: String
    let name: String?
    var color: MapCountryColor
    
    init(countryCode: String, name: String, color: MapCountryColor) {
        self.countryCode = countryCode
        self.name = name
        self.color = color
    }
}

class CountryDataManager: ObservableObject {
    static let shared = CountryDataManager()
    
    @Published var colorMap: [String : Color] = [:]
    @Published var countriesData: [MapCountryModel] = [
        MapCountryModel(countryCode: "GL", name: "Greenland", color: .grey),
        MapCountryModel(countryCode: "IS", name: "Iceland", color: .grey),
        MapCountryModel(countryCode: "PT", name: "Portugal", color: .grey),
        MapCountryModel(countryCode: "MA", name: "Morocco", color: .grey),
        MapCountryModel(countryCode: "ES", name: "Spain", color: .grey),
        MapCountryModel(countryCode: "TN", name: "Tunisia", color: .grey),
        MapCountryModel(countryCode: "DZ", name: "Algeria", color: .grey),
        MapCountryModel(countryCode: "BE", name: "Belgium", color: .grey),
        MapCountryModel(countryCode: "IT", name: "Italy", color: .grey),
        MapCountryModel(countryCode: "BY", name: "Belarus", color: .grey),
        MapCountryModel(countryCode: "PL", name: "Poland", color: .grey),
        MapCountryModel(countryCode: "JO", name: "Jordan", color: .grey),
        MapCountryModel(countryCode: "TM", name: "Turkmenistan", color: .grey),
        MapCountryModel(countryCode: "KZ", name: "Kazakhstan", color: .grey),
        MapCountryModel(countryCode: "FI", name: "Finland", color: .grey),
        MapCountryModel(countryCode: "DE", name: "Germany", color: .grey),
        MapCountryModel(countryCode: "SE", name: "Sweden", color: .grey),
        MapCountryModel(countryCode: "NO", name: "Norway", color: .grey),
        MapCountryModel(countryCode: "UA", name: "Ukraine", color: .green),
        MapCountryModel(countryCode: "IL", name: "Israel", color: .grey),
        MapCountryModel(countryCode: "SA", name: "Saudi Arabia", color: .grey),
        MapCountryModel(countryCode: "IQ", name: "Iraq", color: .grey),
        MapCountryModel(countryCode: "AZ", name: "Azerbaijan", color: .grey),
        MapCountryModel(countryCode: "IR", name: "Iran", color: .grey),
        MapCountryModel(countryCode: "GE", name: "Georgia", color: .grey),
        MapCountryModel(countryCode: "SY", name: "Syria", color: .grey),
        MapCountryModel(countryCode: "TR", name: "Turkey", color: .grey),
        MapCountryModel(countryCode: "AM", name: "Armenia", color: .grey),
        MapCountryModel(countryCode: "CY", name: "Cyprus", color: .grey),
        MapCountryModel(countryCode: "IE", name: "Ireland", color: .grey),
        MapCountryModel(countryCode: "UK", name: "United Kingdom", color: .grey),
        MapCountryModel(countryCode: "CH", name: "Switzerland", color: .grey),
        MapCountryModel(countryCode: "AT", name: "Austria", color: .grey),
        MapCountryModel(countryCode: "CZ", name: "Czech Republic", color: .grey),
        MapCountryModel(countryCode: "SK", name: "Slovakia", color: .grey),
        MapCountryModel(countryCode: "HU", name: "Hungary", color: .grey),
        MapCountryModel(countryCode: "LT", name: "Lithuania", color: .grey),
        MapCountryModel(countryCode: "RU", name: "Russia", color: .grey),
        MapCountryModel(countryCode: "LV", name: "Latvia", color: .grey),
        MapCountryModel(countryCode: "MD", name: "Moldova", color: .grey),
        MapCountryModel(countryCode: "RO", name: "Romania", color: .grey),
        MapCountryModel(countryCode: "BG", name: "Bulgaria", color: .grey),
        MapCountryModel(countryCode: "AL", name: "Albania", color: .grey),
        MapCountryModel(countryCode: "EE", name: "Estonia", color: .grey),
        MapCountryModel(countryCode: "LB", name: "Lebanon", color: .grey),
        MapCountryModel(countryCode: "AD", name: "Andorra", color: .grey),
        MapCountryModel(countryCode: "SM", name: "San Marino", color: .grey),
        MapCountryModel(countryCode: "MC", name: "Monaco", color: .grey),
        MapCountryModel(countryCode: "LU", name: "Luxembourg", color: .grey),
        MapCountryModel(countryCode: "FR", name: "France", color: .grey),
        MapCountryModel(countryCode: "LI", name: "Liechtenstein", color: .grey),
        MapCountryModel(countryCode: "NL", name: "Netherlands", color: .grey),
        MapCountryModel(countryCode: "BA", name: "Bosnia and Herzegovina", color: .grey),
        MapCountryModel(countryCode: "SI", name: "Slovenia", color: .grey),
        MapCountryModel(countryCode: "MK", name: "North Macedonia", color: .grey),
        MapCountryModel(countryCode: "HR", name: "Croatia", color: .grey),
        MapCountryModel(countryCode: "DK", name: "Denmark", color: .grey),
        MapCountryModel(countryCode: "MT", name: "Malta", color: .grey),
        MapCountryModel(countryCode: "ME", name: "Montenegro", color: .grey),
        MapCountryModel(countryCode: "SR", name: "Suriname", color: .grey),
        MapCountryModel(countryCode: "GR", name: "Greece", color: .grey),
        MapCountryModel(countryCode: "IM", name: "Isle of Man", color: .grey),
        MapCountryModel(countryCode: "VA", name: "Vatican City", color: .grey),
        MapCountryModel(countryCode: "GB", name: "Great Britain", color: .grey),
        MapCountryModel(countryCode: "RS", name: "Serbia", color: .grey),
        MapCountryModel(countryCode: "XK", name: "Kosovo", color: .grey),
        MapCountryModel(countryCode: "SJ", name: "Norway", color: .grey),
        MapCountryModel(countryCode:"EH", name: "Western Sahara",color: .grey),
        MapCountryModel(countryCode:"LY", name: "Libya",color: .grey),
        MapCountryModel(countryCode:"EG", name: "Egypt",color: .grey),
        MapCountryModel(countryCode: "SD", name: "Sudan",color: .grey),
        MapCountryModel(countryCode: "TD", name: "Chad",color: .grey),
        MapCountryModel(countryCode:"NE", name: "Niger",color: .grey),
        MapCountryModel(countryCode:"ML", name: "Mali",color: .grey),
        MapCountryModel(countryCode:"MR", name: "Mauritania",color: .grey),
        MapCountryModel(countryCode:"SN", name: "Senegal",color: .grey),
        MapCountryModel(countryCode:"GN", name: "Guinea",color: .grey),
        MapCountryModel(countryCode:"LR", name: "Liberia",color: .grey),
        MapCountryModel(countryCode:"CI", name: "Côte d'Ivoire",color: .grey),
        MapCountryModel(countryCode:"GH", name: "Ghana",color: .grey),
        MapCountryModel(countryCode:"BF", name: "Burkina Faso",color: .grey),
        MapCountryModel(countryCode:"SL", name: "Sierra Leone", color: .grey),
        MapCountryModel(countryCode: "GW", name: "Guinea-Bissau", color: .grey),
        MapCountryModel(countryCode: "TG", name: "Togo", color: .grey),
        MapCountryModel(countryCode: "BJ", name: "Benin", color: .grey),
        MapCountryModel(countryCode: "NG", name: "Nigeria", color: .grey),
        MapCountryModel(countryCode: "CM", name: "Cameroon", color: .grey),
        MapCountryModel(countryCode: "CF", name: "Central African Republic",color: .grey),
        MapCountryModel(countryCode: "SS", name: "South Sudan", color: .grey),
        MapCountryModel(countryCode: "ET", name: "Ethiopia", color: .grey),
        MapCountryModel(countryCode: "CO", name: "Colombia", color: .grey),
        MapCountryModel(countryCode: "ER", name: "Eritrea", color: .grey),
        MapCountryModel(countryCode: "DJ", name: "Djibouti", color: .grey ),
        MapCountryModel(countryCode: "KE", name: "Kenya", color: .grey ),
        MapCountryModel(countryCode: "GQ", name: "Equatorial Guinea", color: .grey),
        MapCountryModel(countryCode: "GA", name: "Gabon", color: .grey),
        MapCountryModel(countryCode: "CG", name: "Republic of the Congo", color: .grey),
        MapCountryModel(countryCode: "CD", name: "Democratic Republic of the Congo", color: .grey),
        MapCountryModel(countryCode: "UG", name: "Uganda", color: .grey),
        MapCountryModel(countryCode: "AO", name: "Angola", color: .grey),
        MapCountryModel(countryCode: "ZM", name: "Zambia", color: .grey),
        MapCountryModel(countryCode: "MW", name: "Malawi", color: .grey),
        MapCountryModel(countryCode: "MZ", name: "Mozambique", color: .grey),
        MapCountryModel(countryCode: "ZW", name: "Zimbabwe", color: .grey),
        MapCountryModel(countryCode: "BW", name: "Botswana", color: .grey),
        MapCountryModel(countryCode: "NA", name: "Namibia", color: .grey),
        MapCountryModel(countryCode: "ZA", name: "South Africa", color: .grey),
        MapCountryModel(countryCode: "MG", name: "Madagascar", color: .grey),
        MapCountryModel(countryCode: "SO", name: "Somalia", color: .grey),
        MapCountryModel(countryCode: "TZ", name: "Tanzania", color: .grey),
        MapCountryModel(countryCode: "RW", name: "Rwanda", color: .grey),
        MapCountryModel(countryCode: "YE", name: "Yemen", color: .grey),
        MapCountryModel(countryCode: "OM", name: "Oman", color: .grey),
        MapCountryModel(countryCode: "AE", name: "United Arab Emirates", color: .grey),
        MapCountryModel(countryCode: "QA", name: "Qatar", color: .grey),
        MapCountryModel(countryCode: "KW", name: "Kuwait", color: .grey),
        MapCountryModel(countryCode: "PS", name: "State of Palestine", color: .grey),
        MapCountryModel(countryCode: "AF", name: "Afghanistan", color: .grey),
        MapCountryModel(countryCode: "UZ", name: "Uzbekistan", color: .grey),
        MapCountryModel(countryCode: "KG", name: "Kyrgyzstan", color: .grey),
        MapCountryModel(countryCode: "TJ", name: "Tajikistan", color: .grey),
        MapCountryModel(countryCode: "PK", name: "Pakistan", color: .grey),
        MapCountryModel(countryCode: "IN", name: "India", color: .grey),
        MapCountryModel(countryCode: "NP", name: "Nepal", color: .grey),
        MapCountryModel(countryCode: "BT", name: "Bhutan", color: .grey),
        MapCountryModel(countryCode: "MN", name: "Mongolia", color: .grey),
        MapCountryModel(countryCode: "CN", name: "China", color: .grey),
        MapCountryModel(countryCode: "MM", name: "Myanmar", color: .grey),
        MapCountryModel(countryCode: "BD", name: "Bangladesh", color: .grey),
        MapCountryModel(countryCode: "TH", name: "Thailand", color: .grey),
        MapCountryModel(countryCode: "KH", name: "Cambodia", color: .grey),
        MapCountryModel(countryCode: "VN", name: "Vietnam", color: .grey),
        MapCountryModel(countryCode: "LA", name: "Laos", color: .grey),
        MapCountryModel(countryCode: "MY", name: "Malaysia", color: .grey),
        MapCountryModel(countryCode: "ID", name: "Indonesia", color: .grey),
        MapCountryModel(countryCode: "PG", name: "Papua New Guinea", color: .grey),
        MapCountryModel(countryCode: "SB", name: "Solomon Islands", color: .grey),
        MapCountryModel(countryCode: "NC", name: "New Caledonia", color: .grey),
        MapCountryModel(countryCode: "FJ", name: "Fiji", color: .grey),
        MapCountryModel(countryCode: "AU", name: "Australia", color: .grey),
        MapCountryModel(countryCode: "NZ", name: "New Zealand", color: .grey),
        MapCountryModel(countryCode: "TF", name: "French Southern and Antarctic Territories", color: .grey),
        MapCountryModel(countryCode: "VU", name: "Vanuatu", color: .grey),
        MapCountryModel(countryCode: "KR", name: "South Korea", color: .grey),
        MapCountryModel(countryCode: "KP", name: "North Korea", color: .grey),
        MapCountryModel(countryCode: "JP", name: "Japan", color: .grey),
        MapCountryModel(countryCode: "TW", name: "Taiwan", color: .grey),
        MapCountryModel(countryCode: "PH", name: "Philippines", color: .grey),
        MapCountryModel(countryCode: "LK", name: "Sri Lanka", color: .grey),
        MapCountryModel(countryCode: "TL", name: "Timor-Leste", color: .grey),
        MapCountryModel(countryCode: "FK", name: "Falkland Islands", color: .grey),
        MapCountryModel(countryCode: "AR", name: "Argentina", color: .grey),
        MapCountryModel(countryCode: "CL", name: "Chile", color: .grey),
        MapCountryModel(countryCode: "UY", name: "Uruguay", color: .grey),
        MapCountryModel(countryCode: "BR", name: "Brazil", color: .grey),
        MapCountryModel(countryCode: "BO", name: "Bolivia", color: .grey),
        MapCountryModel(countryCode: "PY", name: "Paraguay", color: .grey),
        MapCountryModel(countryCode: "PE", name: "Peru", color: .grey),
        MapCountryModel(countryCode: "EC", name: "Ecuador", color: .grey),
        MapCountryModel(countryCode: "VE", name: "Venezuela", color: .grey),
        MapCountryModel(countryCode: "GY", name: "Guyana", color: .grey),
        MapCountryModel(countryCode: "GF", name: "French Guiana", color: .grey),
        MapCountryModel(countryCode: "TT", name: "Trinidad and Tobago", color: .grey),
        MapCountryModel(countryCode: "PA", name: "Panama", color: .grey),
        MapCountryModel(countryCode: "CR", name: "Costa Rica", color: .grey),
        MapCountryModel(countryCode: "NI", name: "Nicaragua", color: .grey),
        MapCountryModel(countryCode: "HN", name: "Honduras", color: .grey),
        MapCountryModel(countryCode: "BZ", name: "Belize", color: .grey),
        MapCountryModel(countryCode: "MX", name: "Mexico", color: .grey),
        MapCountryModel(countryCode: "CU", name: "Cuba", color: .grey),
        MapCountryModel(countryCode: "HT", name: "Haiti", color: .grey),
        MapCountryModel(countryCode: "JM", name: "Jamaica", color: .grey),
        MapCountryModel(countryCode: "DO", name: "Dominican Republic", color: .grey),
        MapCountryModel(countryCode: "PR", name: "Puerto Rico", color: .grey),
        MapCountryModel(countryCode: "BS", name: "Bahamas", color: .grey),
        MapCountryModel(countryCode: "US", name: "United States", color: .grey),
        MapCountryModel(countryCode: "CA", name: "Canada", color: .grey),
        MapCountryModel(countryCode: "GM", name: "Gambia", color: .grey),
        MapCountryModel(countryCode: "LS", name: "Lesotho", color: .grey),
        MapCountryModel(countryCode: "SZ", name: "Eswatini", color: .grey)
        
    ]
    
    var countryNameMap: [String: String] {
        var map = [String: String]()
        for country in countriesData {
            if let name = country.name {
                map[country.countryCode] = name
            }
        }
        return map
    }
    
    init() {
        addColorArray()
    }
    
    func updateCountryColor(byName name: String, newColor: MapCountryColor) {
        for index in countriesData.indices {
            if countriesData[index].name == name {
                countriesData[index].color = newColor
            }
        }
    }
    
    func addColorArray() {
        for country in countriesData {
            colorMap[country.countryCode.uppercased()] = country.color.toSwiftUIColor()
        }
    }
}
