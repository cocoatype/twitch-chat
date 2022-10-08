//  Created by Geoff Pado on 4/18/22.
//  Copyright © 2022 Cocoatype, LLC. All rights reserved.

import Cocoa

struct DownloadedEmote {
    init(image: NSImage, range: ClosedRange<Int>) {
        self.image = image
        self.range = range
    }

    func textAttachment(font: NSFont) -> NSTextAttachment {
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(origin: CGPoint(x: 0, y: font.descender), size: CGSize(width: 22, height: 22))
        return attachment
    }

    private let image: NSImage
    let range: ClosedRange<Int>
}
