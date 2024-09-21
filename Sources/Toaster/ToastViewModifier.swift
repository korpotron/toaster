import SwiftUI

public struct ToastViewModifier<Value, Toast: View>: ViewModifier {
    private let presenting: Binding<Value?>
    private let toast: (_ value: Value) -> Toast

    public init(presenting: Binding<Value?>, @ViewBuilder toast: @escaping (_ value: Value) -> Toast) {
        self.presenting = presenting
        self.toast = toast
    }

    public func body(content: Content) -> some View {
        content
            .overlay {
                overlay
            }
    }

    var value: Value? {
        presenting.wrappedValue
    }

    var overlay: some View {
        Group {
            if let value {
                toast(value)
            }
        }
        .animation(.easeInOut, value: value != nil)
    }
}

#Preview {
    struct Preview: View {
        @State var show = false

        var body: some View {
            TabView {
                Tab {
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
                    .modifier(ToastViewModifier(presenting: .of($show)) { _ in
                        Text("Hello ")
                            .padding()
                            .background(.regularMaterial)
                            .transition(.toast)
                    })
                } label: {
                    Label("Toast", systemImage: "wineglass")
                }
                Tab {

                } label: {
                    Label("Toast", systemImage: "wineglass")
                }
            }
        }
    }

    return Preview()
}
