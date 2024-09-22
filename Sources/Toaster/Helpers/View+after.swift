import SwiftUI

public extension View {
    func after(_ duration: Duration, block: @escaping @Sendable () async -> Void) -> some View {
        task {
            try? await Task.sleep(for: duration)
            await block()
        }
    }
}
