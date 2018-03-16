# Realm Codegen

[Sourcery](https://github.com/krzysztofzablocki/Sourcery) template for Code Generation of [Realm](https://github.com/realm/realm-cocoa/) model files.

Currently a proof of concept, more work and testing on real-world project to come.

## How to use

Annotate a struct as `RealmPersistable` and template will generate Realm model and methods to convert the struct to Realm model and back.

## Example

```
//sourcery: RealmPersistable
struct Order {
    enum Status: String {
        case open = "OPEN"
        case completed = "COMPLETED"
    }

    //sourcery: RealmPersistable
    struct Item {
        let name: String
        let description: String?
        let price: Double
    }

    //sourcery: id
    let uid: String
    let status: Status
    let items: [Item]
```