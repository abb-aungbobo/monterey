//
//  PersistenceControllerImpl.swift
//
//
//  Created by Aung Bo Bo on 27/04/2024.
//

import RealmSwift

final public class PersistenceControllerImpl: PersistenceController {
    public static let shared = PersistenceControllerImpl()
    
    public init() {}
    
    public func add<Element: Object>(entity: Element) throws {
        let realm = try Realm()
        try realm.write {
            realm.add(entity, update: .modified)
        }
    }
    
    public func add<Element: Object>(entities: [Element]) throws {
        let realm = try Realm()
        realm.beginWrite()
        realm.add(entities, update: .modified)
        try realm.commitWrite()
    }
    
    public func get<Element: Object, Key>(ofType type: Element.Type, forPrimaryKey key: Key) throws -> Element?  {
        let realm = try Realm()
        let object = realm.object(ofType: type, forPrimaryKey: key)
        return object
    }
    
    public func get<Element: Object>() throws -> [Element] {
        let realm = try Realm()
        let results = realm.objects(Element.self)
        return Array(results)
    }
    
    public func update<Result>(_ block: (() throws -> Result)) throws {
        let realm = try Realm()
        try realm.write(block)
    }
    
    public func delete<Element: Object>(entity: Element) throws {
        let realm = try Realm()
        try realm.write {
            realm.delete(entity)
        }
    }
}
