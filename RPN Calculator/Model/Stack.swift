//
//  Stack.swift
//  RPN Calculator
//
//  Created by Sukhrob on 13/03/25.
//
import Foundation

struct Stack<T> {
    private var items: [T] = []
    
    func peek() -> T? {
        return items.last
    }
    
    mutating func push(_ element: T) {
        items.append(element)
    }
    
    mutating func pop() -> T? {
        return items.popLast()
    }
    func length() -> Int {
        return items.count
    }
}
