import Foundation

struct MealDetail: Decodable {
    
    struct CodingKeys: CodingKey {
        let stringValue: String
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        init(rawValue: String) {
            self.stringValue = rawValue
        }
        
        var intValue: Int?
        
        init?(intValue: Int) {
            return nil
        }
        
        static var name = CodingKeys(rawValue: "strMeal")
        static var thumb = CodingKeys(rawValue: "strMealThumb")
        static var instructions = CodingKeys(rawValue: "strInstructions")
        
        static func strIngredient(_ index: Int) -> Self {
            CodingKeys(rawValue: "strIngredient\(index)")
        }
        
        static func strMeasure(_ index: Int) -> Self {
            CodingKeys(rawValue: "strMeasure\(index)")
        }
    }
    
//    Added an identifier that would receive a hashable protocol that would not allow errors
//    or duplicate information if the property keys match.
    struct Ingredient: Decodable, Hashable {
        let id: Int
        let name: String
        let measure: String
    }
    
  //  let idMeal: String
    let name: String
    let thumb: URL?
    let instructions: String
    let ingredients: [Ingredient]
    
    // Custom initializer from Decoder to manually decode the MealDetail properties from JSON.
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decoding the properties using the custom coding keys.
        self.name = try container.decode(String.self, forKey: .name)
        self.thumb = try? container.decode(URL.self, forKey: .thumb)
        self.instructions = try container.decode(String.self, forKey: .instructions)
        
        // Decoding ingredients by dynamically checking for ingredient names and measures, adding them if they exist and are not empty.
//        since in the details of the dessert model there are 20 repeating properties
//        that we can combine so as not to write each one through a loop, this is
//        processed and we will save only those properties that have a value (as written in the task)
        var ingredients: [Ingredient] = []
        
        for index in 1...20 {
            if let name = try? container.decode(String.self, forKey: .strIngredient(index)),
               let measure = try? container.decode(String.self, forKey: .strMeasure(index)),
               !name.isEmpty, !measure.isEmpty
            {
                
                ingredients.append(Ingredient(id: index, name: name, measure: measure))
            }
        }
        self.ingredients = ingredients
    }
    
}
