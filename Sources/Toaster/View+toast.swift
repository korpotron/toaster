import SwiftUI

public extension View {
    @inlinable
    func toast<Value>(presenting: Binding<Value?>, @ViewBuilder content: @escaping (Value) -> some View) -> some View {
        modifier(ToastViewModifier(presenting: presenting, toast: content))
    }
}

public extension View {
    func toast(presenting: Binding<Bool>, @ViewBuilder content: @escaping () -> some View) -> some View {
        toast(presenting: .of(presenting)) { _ in
            content()
        }
    }
}

extension Binding<Void?> {
    static func of(_ binding: Binding<Bool>) -> Self {
        .init {
            binding.wrappedValue ? () : nil
        } set: { value in
            binding.wrappedValue = value != nil
        }
    }
}

#Preview {
    struct Preview: View {
        @State var show = false

        var body: some View {
            VStack {
                Button("Toggle") {
                    show.toggle()
                }
                .offset(y: 100)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color.yellow
                    .ignoresSafeArea()
            }
            .toast(presenting: $show) {
                Text("Hello")
                    .padding()
                    .background(.pink)
            }
        }
    }

    return Preview()
}
