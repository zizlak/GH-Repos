//
//  Box.swift
//  GH-Repos
//
//  Created by Aleksandr Kurdiukov on 13.01.22.
//

import Foundation

class Box<T> {

    typealias BoxListener = (T) -> Void

    // MARK: - Properties
    var value: T {
        didSet {
            listener?(value)
        }
    }

    private var listener: BoxListener?

    // MARK: - Init
    init(_ value: T) {
        self.value = value
    }

    // MARK: - Methods
    func bind(listener: @escaping BoxListener) {
        self.listener = listener
        listener(value)
    }
}
