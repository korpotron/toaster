import SwiftUI

public struct ToastRootView<Content: View>: View {
    private let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    @State
    private var root: AnyViewModifier = .identity

    public var body: some View {
        content()
            .modifier(root)
            .environment(\.root, $root)
    }
}

#Preview {
    struct Preview: View {
        @State var show = false

        var body: some View {
            ToastRootView {
                TabView {
                    Tab {
                        ZStack {
                            Color.teal
                                .ignoresSafeArea()
                            Button("Show") {
                                show.toggle()
                            }
                            .offset(y: 100)
                        }
                        .toast(presenting: $show) {
                            Color.black
                                .frame(width: 50, height: 50)
                        }
                    } label: {
                        Label("First", systemImage: "dog")
                    }

                    Tab {

                    } label: {
                        Label("Second", systemImage: "cat")
                    }
                }
            }
        }
    }

    return Preview()
}
