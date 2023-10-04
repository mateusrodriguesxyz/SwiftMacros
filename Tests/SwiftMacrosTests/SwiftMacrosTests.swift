import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

import SwiftMacrosImplementation

let macros: [String: Macro.Type] = [
    "stringify": StringifyMacro.self,
    "URL": URLMacro.self,
    "properties": PropertiesMacro.self,
    "CaseDetection": CaseDetectionMacro.self,
    "AddAsync": AddAsyncMacro.self,
    "DictionaryStorageProperty": DictionaryStoragePropertyMacro.self,
    "DictionaryStorage": DictionaryStorageMacro.self
]

final class SwiftMacrosTests: XCTestCase {
    
    func testStringify() throws {
        assertMacroExpansion(
            """
            #stringify(a + b)
            """,
            expandedSource: 
            """
            (a + b, "a + b")
            """,
            macros: macros
        )
    }
    
    func testURL() throws {
        assertMacroExpansion(
            """
            let valid = #URL("https://swift.org/")
            """,
            expandedSource:
            """
            let valid = URL(string: "https://swift.org/")!
            """,
            macros: macros
        )
        assertMacroExpansion(
            """
            let invalid = #URL("https:// swift.org/")
            """,
            expandedSource:
            """
            let invalid = #URL("https:// swift.org/")
            """,
            diagnostics: [
                DiagnosticSpec(message: #"malformed url: "https:// swift.org/""#, line: 1, column: 15, severity: .error)
            ],
            macros: macros
        )
    }
    
    func testStats() throws {
        assertMacroExpansion(
            """
            struct Character {
                #properties("strength", "dexterity", "constitution", "intelligence", "wisdom", "charisma")
            }
            """,
            expandedSource:
            """
            struct Character {
                var strength: Int = 1
                var dexterity: Int = 1
                var constitution: Int = 1
                var intelligence: Int = 1
                var wisdom: Int = 1
                var charisma: Int = 1
            }
            """,
            macros: macros
        )
    }
    
    func testCaseDetection() {
        assertMacroExpansion(
          """
          @CaseDetection
          enum Animal {
            case dog
            case cat(curious: Bool)
          }
          """,
          expandedSource: 
            """
            enum Animal {
              case dog
              case cat(curious: Bool)

              var isDog: Bool {
                if case .dog = self {
                  return true
                } else {
                  return false
                }
              }

              var isCat: Bool {
                if case .cat = self {
                  return true
                } else {
                  return false
                }
              }
            }
            """,
          macros: macros,
          indentationWidth: .spaces(2)
        )
    }
    
    func testAddAsync() {
        assertMacroExpansion(
        """
        @AddAsync
        func upload(_ data: Data, completion: @escaping (Bool) -> Void) -> Void {
          completion(true)
        }
        """,
        expandedSource:
        """
        func upload(_ data: Data, completion: @escaping (Bool) -> Void) -> Void {
          completion(true)
        }
        
        func upload(_ data: Data) async -> Bool {
          await withCheckedContinuation { continuation in
            upload(data) { returnValue in

              continuation.resume(returning: returnValue)
            }
          }
        }
        """,
            macros: macros,
            indentationWidth: .spaces(2)
        )
    }
    
//    func testCustomDebugStringConvertible() {
//        assertMacroExpansion(
//        """
//        @CustomDebugStringConvertible
//        struct Person {
//            let name: String
//            let age: Int
//        }
//        """,
//        expandedSource:
//        #"""
//        struct Person {
//            let name: String
//            let age: Int
//        }
//        
//        extension Person: CustomDebugStringConvertible {
//            var debugDescription: String {
//                """
//                name: \(name)
//                age: \(age)
//                """
//            }
//        }
//        """#,
//            macros: macros
//        )
//    }
    
    func testDictionaryStorageProperty() {
        assertMacroExpansion(
            """
            struct Person {
                var _storage: [AnyHashable: Any] = [:]
                @DictionaryStorageProperty
                var name: String = "John Appleseed"
            }
            """,
            expandedSource:
            #"""
            struct Person {
                var _storage: [AnyHashable: Any] = [:]
                var name: String = "John Appleseed" {
                    get {
                        _storage["name", default: "John Appleseed"] as! String
                    }
                    set {
                        _storage["name"] = newValue
                    }
                }
            }
            """#,
            macros: macros
        )
    }
    
    func testDictionaryStorage() {
        assertMacroExpansion(
            """
            @DictionaryStorage
            struct Person {
                var name: String = "John Appleseed"
            }
            """,
            expandedSource:
            """
            struct Person {
                var name: String = "John Appleseed" {
                    get {
                        _storage["name", default: "John Appleseed"] as! String
                    }
                    set {
                        _storage["name"] = newValue
                    }
                }
            
                var _storage: [String: Any] = [:]
            }
            """,
            macros: macros
        )
    }
    
}
