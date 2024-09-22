import SwiftUI

struct ToastWrapperModifier<Value, Toast: View>: ViewModifier {
    @Binding var presenting: Value?
    let toast: (_ value: Value) -> Toast

    func body(content: Content) -> some View {
        content
            .overlay {
                Group {
                    if let presenting {
                        toast(presenting)
                    }
                }
                .animation(.easeInOut, value: presenting != nil)
            }
    }
}
