
import Foundation

struct MealsResponse<Data: Decodable>: Decodable {
    let meals: Data
}
