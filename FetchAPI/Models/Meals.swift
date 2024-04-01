
import Foundation

//"meals": [
//{
//"strMeal": "Apam balik",
//"strMealThumb": "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
//"idMeal": "53049"
//},
//{

struct Meals: Decodable {
    let meals: [Meal]
}

struct Meal: Decodable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
