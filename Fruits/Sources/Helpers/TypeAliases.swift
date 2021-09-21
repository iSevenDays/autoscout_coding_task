//
//  TypeAliases.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 20.09.2021.
//

import Foundation
import RealmSwift

typealias CacheBlock = (() -> Realm)
typealias OptionalCacheBlock = (() -> Realm?)
