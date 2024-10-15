//
//  MapModel.swift
//  testMap
//
//  Created by Anatolii Kravchuk on 30.04.2024.
//

import Foundation
import SwiftUI

enum MapCountryColor: String, Codable {
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

class MapCountryModel: Identifiable, ObservableObject, Codable {
    let id = UUID()
    let countryCode: String
    let name: String?
    var color: MapCountryColor
    var power: Int
    
    
    enum CodingKeys: String, CodingKey {
        case countryCode, name, color, power
    }
    
    init(countryCode: String, name: String, color: MapCountryColor, power: Int) {
        self.countryCode = countryCode
        self.name = name
        self.color = color
        self.power = power
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        countryCode = try container.decode(String.self, forKey: .countryCode)
        name = try container.decode(String?.self, forKey: .name)
        color = try container.decode(MapCountryColor.self, forKey: .color)
        power = try container.decode(Int.self, forKey: .power)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(countryCode, forKey: .countryCode)
        try container.encode(name, forKey: .name)
        try container.encode(color, forKey: .color)
        try container.encode(power, forKey: .power)
    }
}

class CountryDataManager: ObservableObject {
    static let shared = CountryDataManager()
    
    @Published var colorMap: [String : Color] = [:]
    @Published var countryBackgroundColor: [(String, Color, String, Int)] = []
    @Published var countriesData: [MapCountryModel] = []
    @Published var opacity: Double = 1.0 //For fade animation
    
    private let userDefaultsKey = "SavedCountriesData"
    
    init() {
        loadCountriesData()
        addColorArray()
        updateCountryBackgroundColor()
    }
    
    func saveCountriesData() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(countriesData)
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        } catch {
            print("Unable to encode countriesData: \(error)")
        }
    }
    
    func loadCountriesData() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey) {
            do {
                let decoder = JSONDecoder()
                countriesData = try decoder.decode([MapCountryModel].self, from: data)
            } catch {
                print("Unable to decode countriesData: \(error)")
                loadDefaultCountriesData()
            }
        } else {
            loadDefaultCountriesData()
        }
    }
    
    func loadDefaultCountriesData() {
        // Load the default countries data here
        countriesData = [
            MapCountryModel(countryCode: "GL", name: "Greenland", color: .grey, power: 50),
            MapCountryModel(countryCode: "IS", name: "Iceland", color: .grey, power: 60),
            MapCountryModel(countryCode: "PT", name: "Portugal", color: .grey, power: 170),
            MapCountryModel(countryCode: "MA", name: "Morocco", color: .grey, power: 120),
            MapCountryModel(countryCode: "ES", name: "Spain", color: .grey, power: 200),
            MapCountryModel(countryCode: "TN", name: "Tunisia", color: .grey, power: 100),
            MapCountryModel(countryCode: "DZ", name: "Algeria", color: .grey, power: 150),
            MapCountryModel(countryCode: "BE", name: "Belgium", color: .grey, power: 180),
            MapCountryModel(countryCode: "IT", name: "Italy", color: .grey, power: 220),
            MapCountryModel(countryCode: "BY", name: "Belarus", color: .grey, power: 130),
            MapCountryModel(countryCode: "PL", name: "Poland", color: .grey, power: 170),
            MapCountryModel(countryCode: "JO", name: "Jordan", color: .grey, power: 110),
            MapCountryModel(countryCode: "TM", name: "Turkmenistan", color: .grey, power: 90),
            MapCountryModel(countryCode: "KZ", name: "Kazakhstan", color: .grey, power: 140),
            MapCountryModel(countryCode: "FI", name: "Finland", color: .grey, power: 150),
            MapCountryModel(countryCode: "DE", name: "Germany", color: .grey, power: 300),
            MapCountryModel(countryCode: "SE", name: "Sweden", color: .grey, power: 190),
            MapCountryModel(countryCode: "NO", name: "Norway", color: .grey, power: 160),
            MapCountryModel(countryCode: "UA", name: "Ukraine", color: .grey, power: 220),
            MapCountryModel(countryCode: "IL", name: "Israel", color: .grey, power: 140),
            MapCountryModel(countryCode: "SA", name: "Saudi Arabia", color: .grey, power: 250),
            MapCountryModel(countryCode: "IQ", name: "Iraq", color: .grey, power: 160),
            MapCountryModel(countryCode: "AZ", name: "Azerbaijan", color: .grey, power: 140),
            MapCountryModel(countryCode: "IR", name: "Iran", color: .grey, power: 300),
            MapCountryModel(countryCode: "GE", name: "Georgia", color: .grey, power: 110),
            MapCountryModel(countryCode: "SY", name: "Syria", color: .grey, power: 120),
            MapCountryModel(countryCode: "TR", name: "Turkey", color: .grey, power: 250),
            MapCountryModel(countryCode: "AM", name: "Armenia", color: .grey, power: 100),
            MapCountryModel(countryCode: "CY", name: "Cyprus", color: .grey, power: 90),
            MapCountryModel(countryCode: "IE", name: "Ireland", color: .grey, power: 170),
            MapCountryModel(countryCode: "CH", name: "Switzerland", color: .grey, power: 180),
            MapCountryModel(countryCode: "AT", name: "Austria", color: .grey, power: 160),
            MapCountryModel(countryCode: "CZ", name: "Czech Republic", color: .grey, power: 140),
            MapCountryModel(countryCode: "SK", name: "Slovakia", color: .grey, power: 130),
            MapCountryModel(countryCode: "HU", name: "Hungary", color: .grey, power: 120),
            MapCountryModel(countryCode: "LT", name: "Lithuania", color: .grey, power: 110),
            MapCountryModel(countryCode: "RU", name: "Russia", color: .grey, power: 500),
            MapCountryModel(countryCode: "LV", name: "Latvia", color: .grey, power: 100),
            MapCountryModel(countryCode: "MD", name: "Moldova", color: .grey, power: 90),
            MapCountryModel(countryCode: "RO", name: "Romania", color: .grey, power: 150),
            MapCountryModel(countryCode: "BG", name: "Bulgaria", color: .grey, power: 120),
            MapCountryModel(countryCode: "AL", name: "Albania", color: .grey, power: 80),
            MapCountryModel(countryCode: "EE", name: "Estonia", color: .grey, power: 70),
            MapCountryModel(countryCode: "LB", name: "Lebanon", color: .grey, power: 110),
            MapCountryModel(countryCode: "AD", name: "Andorra", color: .grey, power: 60),
            MapCountryModel(countryCode: "SM", name: "San Marino", color: .grey, power: 50),
            MapCountryModel(countryCode: "MC", name: "Monaco", color: .grey, power: 40),
            MapCountryModel(countryCode: "LU", name: "Luxembourg", color: .grey, power: 70),
            MapCountryModel(countryCode: "FR", name: "France", color: .grey, power: 340),
            MapCountryModel(countryCode: "LI", name: "Liechtenstein", color: .grey, power: 50),
            MapCountryModel(countryCode: "NL", name: "Netherlands", color: .grey, power: 230),
            MapCountryModel(countryCode: "BA", name: "Bosnia and Herzegovina", color: .grey, power: 120),
            MapCountryModel(countryCode: "SI", name: "Slovenia", color: .grey, power: 110),
            MapCountryModel(countryCode: "MK", name: "North Macedonia", color: .grey, power: 100),
            MapCountryModel(countryCode: "HR", name: "Croatia", color: .grey, power: 140),
            MapCountryModel(countryCode: "DK", name: "Denmark", color: .grey, power: 180),
            MapCountryModel(countryCode: "MT", name: "Malta", color: .grey, power: 60),
            MapCountryModel(countryCode: "ME", name: "Montenegro", color: .grey, power: 110),
            MapCountryModel(countryCode: "SR", name: "Suriname", color: .grey, power: 90),
            MapCountryModel(countryCode: "GR", name: "Greece", color: .grey, power: 190),
            MapCountryModel(countryCode: "IM", name: "Isle of Man", color: .grey, power: 50),
            MapCountryModel(countryCode: "VA", name: "Vatican City", color: .grey, power: 20),
            MapCountryModel(countryCode: "GB", name: "Great Britain", color: .grey, power: 300),
            MapCountryModel(countryCode: "RS", name: "Serbia", color: .grey, power: 130),
            MapCountryModel(countryCode: "XK", name: "Kosovo", color: .grey, power: 90),
            MapCountryModel(countryCode: "EH", name: "Western Sahara", color: .grey, power: 70),
            MapCountryModel(countryCode: "LY", name: "Libya", color: .grey, power: 160),
            MapCountryModel(countryCode: "EG", name: "Egypt", color: .grey, power: 210),
            MapCountryModel(countryCode: "SD", name: "Sudan", color: .grey, power: 180),
            MapCountryModel(countryCode: "TD", name: "Chad", color: .grey, power: 150),
            MapCountryModel(countryCode: "NE", name: "Niger", color: .grey, power: 140),
            MapCountryModel(countryCode: "ML", name: "Mali", color: .grey, power: 130),
            MapCountryModel(countryCode: "MR", name: "Mauritania", color: .grey, power: 120),
            MapCountryModel(countryCode: "SN", name: "Senegal", color: .grey, power: 140),
            MapCountryModel(countryCode: "GN", name: "Guinea", color: .grey, power: 120),
            MapCountryModel(countryCode: "LR", name: "Liberia", color: .grey, power: 110),
            MapCountryModel(countryCode: "CI", name: "Côte d'Ivoire", color: .grey, power: 150),
            MapCountryModel(countryCode: "GH", name: "Ghana", color: .grey, power: 170),
            MapCountryModel(countryCode: "BF", name: "Burkina Faso", color: .grey, power: 120),
            MapCountryModel(countryCode: "SL", name: "Sierra Leone", color: .grey, power: 110),
            MapCountryModel(countryCode: "GW", name: "Guinea-Bissau", color: .grey, power: 100),
            MapCountryModel(countryCode: "TG", name: "Togo", color: .grey, power: 90),
            MapCountryModel(countryCode: "BJ", name: "Benin", color: .grey, power: 110),
            MapCountryModel(countryCode: "NG", name: "Nigeria", color: .grey, power: 250),
            MapCountryModel(countryCode: "CM", name: "Cameroon", color: .grey, power: 190),
            MapCountryModel(countryCode: "CF", name: "Central African Republic", color: .grey, power: 130),
            MapCountryModel(countryCode: "SS", name: "South Sudan", color: .grey, power: 140),
            MapCountryModel(countryCode: "ET", name: "Ethiopia", color: .grey, power: 210),
            MapCountryModel(countryCode: "CO", name: "Colombia", color: .grey, power: 180),
            MapCountryModel(countryCode: "ER", name: "Eritrea", color: .grey, power: 120),
            MapCountryModel(countryCode: "DJ", name: "Djibouti", color: .grey, power: 90),
            MapCountryModel(countryCode: "KE", name: "Kenya", color: .grey, power: 190),
            MapCountryModel(countryCode: "GQ", name: "Equatorial Guinea", color: .grey, power: 100),
            MapCountryModel(countryCode: "GA", name: "Gabon", color: .grey, power: 110),
            MapCountryModel(countryCode: "CG", name: "Republic of the Congo", color: .grey, power: 120),
            MapCountryModel(countryCode: "CD", name: "Democratic Republic of the Congo", color: .grey, power: 180),
            MapCountryModel(countryCode: "UG", name: "Uganda", color: .grey, power: 130),
            MapCountryModel(countryCode: "AO", name: "Angola", color: .grey, power: 150),
            MapCountryModel(countryCode: "ZM", name: "Zambia", color: .grey, power: 140),
            MapCountryModel(countryCode: "MW", name: "Malawi", color: .grey, power: 120),
            MapCountryModel(countryCode: "MZ", name: "Mozambique", color: .grey, power: 130),
            MapCountryModel(countryCode: "ZW", name: "Zimbabwe", color: .grey, power: 140),
            MapCountryModel(countryCode: "BW", name: "Botswana", color: .grey, power: 130),
            MapCountryModel(countryCode: "NA", name: "Namibia", color: .grey, power: 120),
            MapCountryModel(countryCode: "ZA", name: "South Africa", color: .grey, power: 220),
            MapCountryModel(countryCode: "MG", name: "Madagascar", color: .grey, power: 100),
            MapCountryModel(countryCode: "SO", name: "Somalia", color: .grey, power: 110),
            MapCountryModel(countryCode: "TZ", name: "Tanzania", color: .grey, power: 150),
            MapCountryModel(countryCode: "RW", name: "Rwanda", color: .grey, power: 110),
            MapCountryModel(countryCode: "YE", name: "Yemen", color: .grey, power: 120),
            MapCountryModel(countryCode: "OM", name: "Oman", color: .grey, power: 140),
            MapCountryModel(countryCode: "AE", name: "United Arab Emirates", color: .grey, power: 180),
            MapCountryModel(countryCode: "QA", name: "Qatar", color: .grey, power: 160),
            MapCountryModel(countryCode: "KW", name: "Kuwait", color: .grey, power: 150),
            MapCountryModel(countryCode: "PS", name: "State of Palestine", color: .grey, power: 70),
            MapCountryModel(countryCode: "AF", name: "Afghanistan", color: .grey, power: 160),
            MapCountryModel(countryCode: "UZ", name: "Uzbekistan", color: .grey, power: 170),
            MapCountryModel(countryCode: "KG", name: "Kyrgyzstan", color: .grey, power: 130),
            MapCountryModel(countryCode: "TJ", name: "Tajikistan", color: .grey, power: 120),
            MapCountryModel(countryCode: "PK", name: "Pakistan", color: .grey, power: 200),
            MapCountryModel(countryCode: "IN", name: "India", color: .grey, power: 350),
            MapCountryModel(countryCode: "NP", name: "Nepal", color: .grey, power: 110),
            MapCountryModel(countryCode: "BT", name: "Bhutan", color: .grey, power: 90),
            MapCountryModel(countryCode: "MN", name: "Mongolia", color: .grey, power: 120),
            MapCountryModel(countryCode: "CN", name: "China", color: .grey, power: 500),
            MapCountryModel(countryCode: "MM", name: "Myanmar", color: .grey, power: 130),
            MapCountryModel(countryCode: "BD", name: "Bangladesh", color: .grey, power: 170),
            MapCountryModel(countryCode: "TH", name: "Thailand", color: .grey, power: 200),
            MapCountryModel(countryCode: "KH", name: "Cambodia", color: .grey, power: 110),
            MapCountryModel(countryCode: "VN", name: "Vietnam", color: .grey, power: 180),
            MapCountryModel(countryCode: "LA", name: "Laos", color: .grey, power: 100),
            MapCountryModel(countryCode: "MY", name: "Malaysia", color: .grey, power: 190),
            MapCountryModel(countryCode: "ID", name: "Indonesia", color: .grey, power: 220),
            MapCountryModel(countryCode: "PG", name: "Papua New Guinea", color: .grey, power: 80),
            MapCountryModel(countryCode: "SB", name: "Solomon Islands", color: .grey, power: 70),
            MapCountryModel(countryCode: "NC", name: "New Caledonia", color: .grey, power: 60),
            MapCountryModel(countryCode: "FJ", name: "Fiji", color: .grey, power: 60),
            MapCountryModel(countryCode: "AU", name: "Australia", color: .grey, power: 300),
            MapCountryModel(countryCode: "NZ", name: "New Zealand", color: .grey, power: 180),
            MapCountryModel(countryCode: "TF", name: "French Southern and Antarctic Territories", color: .grey, power: 50),
            MapCountryModel(countryCode: "VU", name: "Vanuatu", color: .grey, power: 80),
            MapCountryModel(countryCode: "KR", name: "South Korea", color: .grey, power: 250),
            MapCountryModel(countryCode: "KP", name: "North Korea", color: .grey, power: 100),
            MapCountryModel(countryCode: "JP", name: "Japan", color: .grey, power: 300),
            MapCountryModel(countryCode: "TW", name: "Taiwan", color: .grey, power: 180),
            MapCountryModel(countryCode: "PH", name: "Philippines", color: .grey, power: 140),
            MapCountryModel(countryCode: "LK", name: "Sri Lanka", color: .grey, power: 110),
            MapCountryModel(countryCode: "TL", name: "Timor-Leste", color: .grey, power: 90),
            MapCountryModel(countryCode: "FK", name: "Falkland Islands", color: .grey, power: 50),
            MapCountryModel(countryCode: "AR", name: "Argentina", color: .grey, power: 190),
            MapCountryModel(countryCode: "CL", name: "Chile", color: .grey, power: 160),
            MapCountryModel(countryCode: "UY", name: "Uruguay", color: .grey, power: 130),
            MapCountryModel(countryCode: "BR", name: "Brazil", color: .grey, power: 220),
            MapCountryModel(countryCode: "BO", name: "Bolivia", color: .grey, power: 120),
            MapCountryModel(countryCode: "PY", name: "Paraguay", color: .grey, power: 110),
            MapCountryModel(countryCode: "PE", name: "Peru", color: .grey, power: 150),
            MapCountryModel(countryCode: "EC", name: "Ecuador", color: .grey, power: 130),
            MapCountryModel(countryCode: "VE", name: "Venezuela", color: .grey, power: 140),
            MapCountryModel(countryCode: "GY", name: "Guyana", color: .grey, power: 100),
            MapCountryModel(countryCode: "GF", name: "French Guiana", color: .grey, power: 90),
            MapCountryModel(countryCode: "TT", name: "Trinidad and Tobago", color: .grey, power: 120),
            MapCountryModel(countryCode: "PA", name: "Panama", color: .grey, power: 110),
            MapCountryModel(countryCode: "CR", name: "Costa Rica", color: .grey, power: 100),
            MapCountryModel(countryCode: "NI", name: "Nicaragua", color: .grey, power: 90),
            MapCountryModel(countryCode: "HN", name: "Honduras", color: .grey, power: 100),
            MapCountryModel(countryCode: "BZ", name: "Belize", color: .grey, power: 90),
            MapCountryModel(countryCode: "MX", name: "Mexico", color: .grey, power: 230),
            MapCountryModel(countryCode: "CU", name: "Cuba", color: .grey, power: 120),
            MapCountryModel(countryCode: "HT", name: "Haiti", color: .grey, power: 80),
            MapCountryModel(countryCode: "JM", name: "Jamaica", color: .grey, power: 70),
            MapCountryModel(countryCode: "DO", name: "Dominican Republic", color: .grey, power: 130),
            MapCountryModel(countryCode: "PR", name: "Puerto Rico", color: .grey, power: 110),
            MapCountryModel(countryCode: "BS", name: "Bahamas", color: .grey, power: 80),
            MapCountryModel(countryCode: "US", name: "United States", color: .grey, power: 500),
            MapCountryModel(countryCode: "CA", name: "Canada", color: .grey, power: 300),
            MapCountryModel(countryCode: "GM", name: "Gambia", color: .grey, power: 70),
            MapCountryModel(countryCode: "LS", name: "Lesotho", color: .grey, power: 60),
            MapCountryModel(countryCode: "SZ", name: "Eswatini", color: .grey, power: 70),
            MapCountryModel(countryCode: "BN", name: "Brunei", color: .grey, power: 80),
            MapCountryModel(countryCode: "GT", name: "Guatemala", color: .grey, power: 100),
            MapCountryModel(countryCode: "SV", name: "El Salvador", color: .grey, power: 70),
        ]
    }
    
    var countryNameMap: [String: String] {
        var map = [String: String]()
        for country in countriesData {
            if let name = country.name {
                map[country.countryCode] = name
            }
        }
        return map
    }
    
    var countryPowerMap: [String: Int] {
        var map = [String: Int]()
        for country in countriesData {
            map[country.countryCode] = country.power
        }
        return map
    }

    func updateCountryColor(byName name: String, newColor: MapCountryColor, newPower: Int) {
            for index in countriesData.indices {
                if countriesData[index].name == name {
                    countriesData[index].color = newColor
                    countriesData[index].power = newPower
                }
            }
            saveCountriesData()
            addColorArray()
            updateCountryBackgroundColor()
        }
    
    func addColorArray() {
        for country in countriesData {
            colorMap[country.countryCode.uppercased()] = country.color.toSwiftUIColor()
        }
    }
    
    func updateCountryBackgroundColor() {
        let sortedCountries = countriesData.sorted { country1, country2 in
            // Сортировка так, чтобы страны с зелёным цветом шли первыми
            if country1.color == .green && country2.color != .green {
                return true
            } else if country1.color != .green && country2.color == .green {
                return false
            } else {
                return true // остальные страны в любом порядке
            }
        }
        
        countryBackgroundColor = sortedCountries.compactMap { country in
            guard let name = country.name else { return nil }
            let power = country.power
            let countryCode = country.countryCode
//            let countryPower = country.power
            return (name, country.color.toSwiftUIColor(), countryCode, power)
        }
    }
        
    private func mapCountryColorToSwiftUIColor(_ mapColor: MapCountryColor) -> Color {
        mapColor.toSwiftUIColor()
    }
    
}
