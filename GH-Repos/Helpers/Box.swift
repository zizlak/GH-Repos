//
//  Box.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 13.01.22.
//

import Foundation

class Box<T> {
    
    typealias BoxListener = (T) -> Void
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: BoxListener?
    
    func bind(listener: @escaping BoxListener) {
        self.listener = listener
        listener(value)
    }
    
    init(_ value: T) {
        self.value = value
    }
    
}
