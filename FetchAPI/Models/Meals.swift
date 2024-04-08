
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
    let name: String
    let thumb: URL?
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumb = "strMealThumb"
    }
    
}
