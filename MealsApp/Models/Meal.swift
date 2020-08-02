//
//  Meal.swift
//  FoodApp
//
//  Created by Juan Ziegler on 31/07/2020.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

struct Meal: Codable {
    let id: String
    let category: String
    let image: String
    
    var imageURL: URL? {
        return URL(string: image)
    }
    
    let name: String
    let youtubeLink: String
    
    var youtubeLinkURL: URL? {
         let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
         let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
         let range = NSRange(location: 0, length: youtubeLink.count)
         guard let result = regex?.firstMatch(in: youtubeLink, range: range) else {
         return nil
         }
        return URL(string: "https://www.youtube.com/embed/\((youtubeLink as NSString).substring(with: result.range))")
    }
    
    let instructions: String
    let ingredients1: String?
    let ingredients2: String?
    let ingredients3: String?
    let ingredients4: String?
    let ingredients5: String?
    let ingredients6: String?
    let ingredients7: String?
    let ingredients8: String?
    let ingredients9: String?
    let ingredients10: String?
    let ingredients11: String?
    let ingredients12: String?
    let ingredients13: String?
    let ingredients14: String?
    let ingredients15: String?
    let ingredients16: String?
    let ingredients17: String?
    let ingredients18: String?
    let ingredients19: String?
    let ingredients20: String?
    
    var ingredients: [String] {
        var array = [String?]()
        array.append(ingredients1)
        array.append(ingredients2)
        array.append(ingredients3)
        array.append(ingredients4)
        array.append(ingredients5)
        array.append(ingredients6)
        array.append(ingredients7)
        array.append(ingredients8)
        array.append(ingredients9)
        array.append(ingredients10)
        array.append(ingredients11)
        array.append(ingredients12)
        array.append(ingredients13)
        array.append(ingredients14)
        array.append(ingredients15)
        array.append(ingredients16)
        array.append(ingredients17)
        array.append(ingredients18)
        array.append(ingredients19)
        array.append(ingredients20)
        array = array.filter({
            guard let currentIngredient = $0 else {
                return false
            }
            return !currentIngredient.isEmpty
        })
        
        guard let arrayWithoutNils = array as? [String] else {
            return []
        }
        
        return arrayWithoutNils
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case category = "strCategory"
        case image = "strMealThumb"
        case name = "strMeal"
        case instructions = "strInstructions"
        case ingredients1 = "strIngredient1"
        case ingredients2 = "strIngredient2"
        case ingredients3 = "strIngredient3"
        case ingredients4 = "strIngredient4"
        case ingredients5 = "strIngredient5"
        case ingredients6 = "strIngredient6"
        case ingredients7 = "strIngredient7"
        case ingredients8 = "strIngredient8"
        case ingredients9 = "strIngredient9"
        case ingredients10 = "strIngredient10"
        case ingredients11 = "strIngredient11"
        case ingredients12 = "strIngredient12"
        case ingredients13 = "strIngredient13"
        case ingredients14 = "strIngredient14"
        case ingredients15 = "strIngredient15"
        case ingredients16 = "strIngredient16"
        case ingredients17 = "strIngredient17"
        case ingredients18 = "strIngredient18"
        case ingredients19 = "strIngredient19"
        case ingredients20 = "strIngredient20"
        case youtubeLink = "strYoutube"
    }
}
