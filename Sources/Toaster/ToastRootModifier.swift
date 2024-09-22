import SwiftUI
import Combine

public struct ToastRootModifier<Value, Toast: View>: ViewModifier {
    @Binding private var presenting: Value?
    private let toast: (_ value: Value) -> Toast

    public init(presenting: Binding<Value?>, @ViewBuilder toast: @escaping (_ value: Value) -> Toast) {
        _presenting = presenting
        self.toast = toast
    }

    @Environment(\.root)
    private var root

    public func body(content: Content) -> some View {
        if let root {
            content
                .onChange(of: presenting != nil, initial: true) { _, new in
                    root.wrappedValue = AnyViewModifier(ToastWrapperModifier(presenting: $presenting, toast: toast))
                }
        } else {
            content
                .modifier(ToastWrapperModifier(presenting: $presenting, toast: toast))
        }
    }
}

#Preview {
    struct Preview: View {
        @State var show = false

        var body: some View {
            ToastRootView {
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
                        .modifier(ToastRootModifier(presenting: .of($show)) { _ in
                            Text("Hello ")
                                .padding()
                                .background(.regularMaterial)
                                .transition(.toast)
                        })
                    } label: {
                        Label("Toast", systemImage: "wineglass")
                    }
                    Tab {} label: {
                        Label("Toast", systemImage: "wineglass")
                    }
                }
            }
        }
    }

    return Preview()
}
