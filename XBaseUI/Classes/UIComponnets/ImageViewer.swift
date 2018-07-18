//
//  ImageViewer.swift
//  OA
//
//  Created by jerry.jiang on 16/7/12.
//  Copyright © 2016年 to8to. All rights reserved.
//

import UIKit
import XBaseUtils

class ImageViewer: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {

    //MARK: - Public Property
    var imageSource: [AnyObject]? {
        didSet {
            self.reloadData()
        }
    }
    
    var showedItemIndex: Int?
    
    var fetchImage: ((_ Data: Any)->String?)?

    var onSingleTap: (()->Void)?
    var onDoubleTap: (()->Void)?
    var onLongPress: (()->Void)?

    required init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = frame.size

        super.init(frame: frame, collectionViewLayout: layout)

        self.delegate = self
        self.dataSource = self
        self.alwaysBounceHorizontal = true
        self.isPagingEnabled = true
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.register(ImageViewerCell.self, forCellWithReuseIdentifier: String(describing: ImageViewerCell.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.delegate = self
        self.dataSource = self
    }


    //MARK: - UICollectionViewDataSource & UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageSource?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageViewerCell.self), for: indexPath) as! ImageViewerCell
        let data = imageSource![indexPath.item]

        var source = fetchImage?(data)
        if source == nil && data is String {
            source = data as? String
        }
        if source != nil {
            if let img = UIImage(contentsOfFile: source!) {
                cell.imageView.image = img
            } else {
//                cell.imageView.t_setImageWithURLString(source!, placeHolderImage: "icon_header")
                cell.imageView.setImageWithUrlString(source!, placeHolder: "icon_header")
            }
        } else if data is UIImage {
            cell.imageView.image = data as? UIImage
        }
        cell.scrollView.onSingleTap = self.onSingleTap

        return cell
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.showedItemIndex = Int(scrollView.contentOffset.x / SCREEN_WIDTH)
    }
}



private class ImageViewerCell: UICollectionViewCell, UIScrollViewDelegate {

    var imageView: UIImageView
    var scrollView: IVScrollView

    override init(frame: CGRect) {
        scrollView = IVScrollView(frame: frame)
        scrollView = IVScrollView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        scrollView.maximumZoomScale = 3.0
        scrollView.minimumZoomScale = 1.0

        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.isUserInteractionEnabled = false
        imageView.contentMode = .scaleAspectFit

        super.init(frame: frame)

        scrollView.delegate = self
        self.addSubview(scrollView)
        scrollView.addSubview(imageView)
    }

    fileprivate override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
        scrollView.zoomScale = 1.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}


private class IVScrollView: UIScrollView {

    var isZoomed = false
    var onSingleTap: (()->Void)?

    fileprivate var _tapTimer: Timer?

    deinit {
        stopTapTimer()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = event?.allTouches?.first
        guard touch?.tapCount == 2 else { return }

        self.stopTapTimer()
        if isZoomed {
            isZoomed = false
            self.setZoomScale(self.minimumZoomScale, animated: true)
        } else {
            isZoomed = true
            let touchCenter = touch?.location(in: self)
            let zoomSize = CGSize(width: self.frame.width/self.maximumZoomScale, height: self.frame.height/self.maximumZoomScale)
            var zoomRect = CGRect(x: touchCenter!.x - zoomSize.width * 0.5, y: touchCenter!.y - zoomSize.height * 0.5, width: zoomSize.width, height: zoomSize.height)

            if zoomRect.origin.x < 0  {
                zoomRect = CGRect(x: 0, y: zoomRect.origin.y, width: zoomRect.width, height: zoomRect.height );
            }

            if zoomRect.origin.y < 0 {
                zoomRect = CGRect(x: zoomRect.origin.x, y: 0, width: zoomRect.width, height: zoomRect.height );
            }

            if zoomRect.origin.x + zoomRect.width > self.frame.width {
                zoomRect = CGRect(x: self.frame.width - zoomRect.width, y: zoomRect.origin.y, width: zoomRect.width, height: zoomRect.height );
            }

            if zoomRect.origin.y + zoomRect.height > self.frame.height {
                zoomRect = CGRect( x: zoomRect.origin.x, y: self.frame.height - zoomRect.height, width: zoomRect.width, height: zoomRect.height );
            }

            self.zoom(to: zoomRect, animated: true)
        }

    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.tapCount == 1 && event?.allTouches?.first?.tapCount == 1 {
            if _tapTimer != nil {
                stopTapTimer()
            }
            startTapTimer()
        }
    }

    @objc fileprivate func handleTap() {
        onSingleTap?()
    }

    fileprivate func startTapTimer() {
        _tapTimer = Timer(fireAt: Date(timeIntervalSinceNow: 0.2), interval: 0.5, target:self, selector:#selector(handleTap), userInfo:nil, repeats:false)
        RunLoop.current.add(_tapTimer!, forMode: RunLoopMode.defaultRunLoopMode)
    }

    fileprivate func stopTapTimer() {
        if (_tapTimer?.isValid == true) {
            _tapTimer?.invalidate()
        }
        _tapTimer = nil
    }
}
