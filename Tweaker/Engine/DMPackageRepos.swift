//
//  DMPackageRepos.swift
//  Tweaker
//
//  Created by Lakr Aream on 2019/7/11.
//  Copyright © 2019 Lakr Aream. All rights reserved.
//

// MARK: RAM

class DMPackageRepos {
    
    public var name                 = String()
    public var link                 = String()
    public var icon                 = String()
    public var sort_ID              = Int()
}

// MARK: DATABASE
class DBMPackageRepos: WCDBSwift.TableCodable {
    
    var name: String?
    var link: String?
    var icon: String?
    var sort_id: Int?
    
    enum CodingKeys: String, CodingTableKey { // swiftlint:disable:next nesting
        typealias Root = DBMPackageRepos
        
        // swiftlint:disable:next redundant_string_enum_value
        case name = "name"
        // swiftlint:disable:next redundant_string_enum_value
        case link = "link"
        // swiftlint:disable:next redundant_string_enum_value
        case icon = "icon"
        // swiftlint:disable:next redundant_string_enum_value
        case sort_id = "sort_id"
        
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        
        static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
            return [
                link: ColumnConstraintBinding(isPrimary: true, isUnique: true)
            ]
        }
    }
    
}
