import SwiftMacros
import Foundation

let a = 17
let b = 25

let (result, code) = #stringify(a + b)

print("The value \(result) was produced by the code \"\(code)\"")


@AddAsync
func upload(_ data: Data, completion: @escaping (Bool) -> Void) -> Void {
    completion(true)
}


@Equatable
class Person1 {
    
    let name: String
    let age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
}

@DictionaryStorage
struct Person2 {
    var name: String = "Joao"
    var age: Int = 25
}

//@CloudKitModel
//struct Person3 {
//    var name: String = "Joao"
//    var age: Int = 25
//}

