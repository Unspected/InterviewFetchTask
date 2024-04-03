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
        
        static var strMeal = CodingKeys(rawValue: "strMeal")
        static var strMealThumb = CodingKeys(rawValue: "strMealThumb")
        static var strInstructions = CodingKeys(rawValue: "strInstructions")
        
        static func strIngredient(_ index: Int) -> Self {
            CodingKeys(rawValue: "strIngredient\(index)")
        }
        
        static func strMeasure(_ index: Int) -> Self {
            CodingKeys(rawValue: "strMeasure\(index)")
        }
    }
    
    struct Ingredient: Decodable {
        let name: String
        let measure: String
    }
    
  //  let idMeal: String
    let strMeal: String
    let strMealThumb: URL?
    let strInstructions: String
    let ingredients: [Ingredient]
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.strMeal = try container.decode(String.self, forKey: .strMeal)
        self.strMealThumb = try? container.decode(URL.self, forKey: .strMealThumb)
        self.strInstructions = try container.decode(String.self, forKey: .strInstructions)
        
        var ingredients: [Ingredient] = []
        
        for index in 1...20 {
            if let name = try? container.decode(String.self, forKey: .strIngredient(index)),
               let measure = try? container.decode(String.self, forKey: .strMeasure(index)),
               !name.isEmpty, !measure.isEmpty
            {
                
                ingredients.append(Ingredient(name: name, measure: measure))
            }
        }
        self.ingredients = ingredients
    }
    
}
