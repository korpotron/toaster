import SwiftUI

struct AnyViewModifier: ViewModifier {
    let modify: (Content) -> AnyView

    init(block: @escaping (Content) -> some View) {
        self.modify = { content in
            AnyView(block(content))
        }
    }

    init<T: ViewModifier>(_ modifier: T) {
        self.init { content in
            content
                .modifier(modifier)
        }
    }

    func body(content: Content) -> some View {
        modify(content)
    }
}

extension AnyViewModifier {
    static let identity = Self { content in
        content
    }
}
