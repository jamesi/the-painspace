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

let from = [0, 1, 2, 3]
let to = [2, 1, 0, 4]

let result = diff(from: from, to: to)

print(result)

let from_s = ["Zero", "One", "Two", "Three"]
let to_s = ["Two", "One", "Zero", "Four"]
let result_s = diff(from: from_s, to: to_s)

print(result_s)
