//
//  ActivityController.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 7/24/22.
//

import Foundation
import SwiftUI
//import LinkPresentation
//import CoreMedia
//
//class ShareImage: UIActivityItemProvider, ObservableObject {
//    var image: UIImage
//    var title: String
//    var item: String
//
//    var action:([Any]) -> Void
//    init (title: String, action:([Any]) -> Void) {
//    self.title = title
//    self.item = item
//    self.action = action
//    super.init()
// }
//
//    override var item: Any {
//        get {
//            return self.image
//        }
//    }
//    override init(placeholderItem: Any) {
//        guard let image = placeholderItem as? UIImage else {
//            fatalError("Couldn't create image from provided item")
//        }
//        self.image = image
//        super.init(placeholderItem: placeholderItem)
//    }
//    override func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
//
//        let metadata = LPLinkMetadata()
//        metadata.title = "Result Image"
//
//        var thumbnail: NSSecureCoding = NSNull()
//        if let imageData = self.image.pngData() {
//            thumbnail = NSData(data: imageData)
//        }
//        metadata.imageProvider = NSItemProvider(item: thumbnail, typeIdentifier: "public.png")
//        return metadata
//    }
//
//    func actionSheet(image: UIImage?) {
//            guard let data = image else { return }
//            let item = ShareImage(placeholderItem: data)
//            let activityViewController = UIActivityViewController(activityItems: [item], applicationActivities: nil)
//
//            UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
//        }
//
//}

struct ShareSheet: UIViewControllerRepresentable {

    var items: [Any]
   
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {

    }
    
}


//struct ShareSheet: UIViewControllerRepresentable {
//    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
//
//    let activityItems: [Any]
//    let applicationActivities: [UIActivity]? = nil
//    let excludedActivityTypes: [UIActivity.ActivityType]? = nil
//    let callback: Callback? = nil
//
//    func makeUIViewController(context: Context) -> UIActivityViewController {
//        let controller = UIActivityViewController(
//            activityItems: activityItems,
//            applicationActivities: applicationActivities)
//        controller.excludedActivityTypes = excludedActivityTypes
//        controller.completionWithItemsHandler = callback
//        return controller
//    }
//
//    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
//        // nothing to do here
//    }
//}
