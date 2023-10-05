https://swift-ast-explorer.com


# CloudKitModel + CloudKitModelProperty Macros

Input:

```swift
@CloudKitModel
struct Person {
    var name: String?
    var age: Int?
}
```

Output (Step 1):

```
struct Person: CloudKitModel {

    var record: CKRecord = CKRecord(recordType: "Person")

    @CloudKitModelProperty
    var name: String?
    @CloudKitModelProperty
    var age: Int?

    init(name: String, age: Int) {
        self.record["name"] = name
        self.record["age"] = age
    }

}
```

Output (Step2):

```swift
struct Person: CloudKitModel {
    
    var record: CKRecord = CKRecord(recordType: "Person")
    
    var name: String? {
        get {
            record.value(forKey: "name") as? String
        }
        set {
            record.setValue(newValue, forKey: "name")
        }
    }
    
    var age: Int? {
        get {
            record.value(forKey: "age") as? Int
        }
        set {
            record.setValue(newValue, forKey: "age")
        }
    }
    
    init(name: String, age: Int) {
        self.record["name"] = name
        self.record["age"] = age
    }
    
}
```
