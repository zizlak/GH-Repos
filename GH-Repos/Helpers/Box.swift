//
//  Box.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 13.01.22.
//

import Foundation

class Box<T> {
    
    typealias Listener = (T) -> Void
    
    private var value: T {
        didSet {
            listener?(value)
        }
    }
    
    var listener: Listener?
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }
    
    init(_ value: T) {
        self.value = value
    }
    
}