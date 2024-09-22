import SwiftUI

extension Binding<Void?> {
    static func of(_ binding: Binding<Bool>) -> Self {
        .init {
            binding.wrappedValue ? () : nil
        } set: { value in
            binding.wrappedValue = value != nil
        }
    }
}
