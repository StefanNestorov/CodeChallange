//
//  Helpers.swift
//  Code_Challenge
//
//  Created by Stefan Nestorov on 18.05.22.
//  Copyright © 2022 JOOR. All rights reserved.
//

import Foundation
import Combine
import UIKit

extension UITextField {
    func textPublisher() -> AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .map { ($0.object as? UITextField)?.text  ?? "" }
            .eraseToAnyPublisher()
    }
}

extension Published.Publisher {
    var didSet: AnyPublisher<Value, Never> {
        self.receive(on: RunLoop.main).eraseToAnyPublisher()
    }
}
