//
//  main.swift
//  NQueensProblem
//
//  Created by 纬洲 冯 on 1/3/16.
//  Copyright © 2016 dopcn. All rights reserved.
//

import Foundation

struct NQueensProblem {
    private let size: Int
    
    init(boardSize: Int) {
        //size start from 1
        size = boardSize>0 ? boardSize : 1
    }
    
    func solutions() -> [[(Int, Int)]] {
        func isSafe(solution: [(Int, Int)], atColumn column: Int) -> Bool {
            let (colX, colY) = solution[column]
            return solution.reduce(true, combine: { (isSafe, location) -> Bool in
                let (locX, locY) = location
                if locX == colX && locY == colY {
                    return isSafe
                } else {
                    return isSafe &&
                        !(locX == colX || locY == colY || (locX+locY) == (colX+colY) || (locX-locY) == (colX-colY))
                }
            })
        }
        
        //column start from 0
        func queenCols(column: Int) -> [[(Int, Int)]] {
            if column == 0 {
                return Array(0..<size).map{ [(0, $0)] }
            } else {
                return queenCols(column-1).map({ (partSolution) -> [[(Int, Int)]] in
                    return Array(0..<size).map { partSolution + [(column, $0)] }
                }).flatMap({ $0 }).filter{ isSafe($0, atColumn: column) }
            }
        }
        
        return queenCols(size-1)
    }
}

var queen = NQueensProblem(boardSize: 8)
print(queen.solutions().count)

