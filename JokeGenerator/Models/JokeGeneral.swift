import UIKit

struct JokeGeneral: Decodable {
    let id: Int
    let type: String
    let setup: String
    let punchline: String
}
