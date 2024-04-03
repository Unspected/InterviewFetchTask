
import Foundation

//"meals": [
//{
//"strMeal": "Apam balik",
//"strMealThumb": "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
//"idMeal": "53049"
//},
//{

// Model
struct Meal: Decodable, Identifiable {
    let id: String
    let strMeal: String
    let strMealThumb: URL?
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case strMeal
        case strMealThumb
    }
    
}
