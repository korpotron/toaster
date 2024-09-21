import SwiftUI

public extension AnyTransition {
    static var toast: AnyTransition {
        .asymmetric(
            insertion: .opacity.combined(with: .push(from: .bottom)),
            removal: .opacity
        )
    }
}
