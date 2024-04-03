
import Foundation

// generic type for the same name of property in Json data in models
struct MealsResponse<Data: Decodable>: Decodable {
    let meals: Data
}
