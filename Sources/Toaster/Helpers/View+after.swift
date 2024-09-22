import SwiftUI

public extension View {
    func after(_ duration: Duration, block: @escaping () -> Void) -> some View {
        task {
            try? await Task.sleep(for: duration)
            block()
        }
    }
}
