//
//  RealmPersistable.swift
//  RealmPersistableSourcery
//
//  Created by Petr Zvoníček on 09.03.18.
//  Copyright © 2018 Petr Zvoníček. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmObject: class {
    associatedtype S: RealmRepresentable
    init(model: S)
    var model: S { get }
}

extension List {
    convenience init(array: [Element]) {
        self.init()
        array.forEach(self.append)
    }

    var array: [Element] {
        return self.map {$0}
    }
}

extension List where Element: RealmObject {
    var array: [Element.S] {
        return self.map { $0.model }
    }
}

extension Array where Element: RealmCollectionValue {
    var realmList: List<Element> {
        return List(array: self)
    }
}

extension Array where Element: RealmRepresentable, Element.PersistingObjectType: RealmCollectionValue, Element.PersistingObjectType.S == Element {
    var realmList: List<Element.PersistingObjectType> {
        let x = self.map { Element.PersistingObjectType.init(model: $0) }
        return List(array: x)
    }
}

protocol RealmRepresentable {
    associatedtype PersistingObjectType: RealmObject
    var persistenceObject: PersistingObjectType { get }
}

extension Array where Element: RealmRepresentable {
    var persistenceArray: [Element.PersistingObjectType] {
        return self.map { $0.persistenceObject }
    }
}
