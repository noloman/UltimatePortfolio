//
//  Binding+OnChange.swift
//  Ultimate Portfolio
//
//  Created by Manu on 04/04/2022.
//

import Foundation
import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Self {
        return Binding {
            self.wrappedValue
        } set: { newValue in
            self.wrappedValue = newValue
            handler()
        }
    }
}
