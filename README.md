
# CloudKitModel 

Given:

```swift
@CloudKitModel
struct Person {
    var name: String?
    var age: Int?
}
```

Expand to:

```swift
@CloudKitModel
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
