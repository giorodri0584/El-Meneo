//
//  SwiftUIViewPreviewHelper.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 9/28/21.
//

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13, *)
public struct UIViewPreview<View: UIView>: UIViewRepresentable {
    public let view: View

    public init(_ builder: @escaping () -> View) {
        view = builder()
    }

    // MARK: - UIViewRepresentable
    public func makeUIView(context: Context) -> UIView {
        return view
    }

    public func updateUIView(_ view: UIView, context: Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
#endif

//this is the part that goes in the view for the previews
//#if canImport(SwiftUI) && DEBUG
//import SwiftUI
//
//@available(iOS 13.0, *)
//struct SimpleView_Preview: PreviewProvider {
//  static var previews: some View {
//    UIViewPreview {
//      let button = SimpleView() // change the view name to preview
//      return button
//    }.previewLayout(.sizeThatFits)
//     .padding(10)
//  }
//}
//#endif
