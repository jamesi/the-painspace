//
//  Diff.swift
//  ThePainspace
//
//  Created by James Ireland on 11/12/2018.
//  Copyright © 2018 James Ireland. Available under the MIT license.
//

import Foundation

typealias Index = Int

struct Diff {
    var inserts: [Index] = []
    var deletes: [Index] = []
    var moves: [(from: Index, to: Index)] = []
}

func elementIndexes<E>(for array: [E]) -> [E: Index] where E: Hashable {
    var result: [E: Index] = [:]
    for (index, element) in array.enumerated() {
        result[element] = index
    }
    return result
}

func diff<E>(from: [E], to: [E]) -> Diff where E: Hashable {
    
    let fromIndexes = elementIndexes(for: from)
    let toIndexes = elementIndexes(for: to)
    
    // find deleted and moved items
    var result = Diff()
    for (index, item) in from.enumerated() {
        if let toIndex = toIndexes[item] {
            if (index != toIndex) {
                // index is different, item has moved
                result.moves.append((index, toIndex))
            }
        } else {
            // no toIndex, item has been deleted
            result.deletes.append(index)
        }
    }
    
    // find inserted items
    for (index, item) in to.enumerated() {
        if fromIndexes[item] == nil {
            // no fromIndex, item has been inserted
            result.inserts.append(index)
        }
    }
    
    return result
}
