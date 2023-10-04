import SwiftSyntax
import SwiftSyntaxMacros
import CloudKit

#warning("Not Implemented")
public struct CloudKitModelMacro { }

protocol CloudKitModel { }

struct Person: CloudKitModel {
    
    var record: CKRecord = CKRecord(recordType: "Person")
    
    @CloudKitModelProperty
    var name: String? {
        get {
            record.value(forKey: "name") as? String
        }
        set {
            record.setValue(newValue, forKey: "name")
        }
    }
    
    @CloudKitModelProperty
    var age: Int? {
        get {
            record.value(forKey: "age") as? Int
        }
        set {
            record.setValue(newValue, forKey: "age")
        }
    }
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
}
