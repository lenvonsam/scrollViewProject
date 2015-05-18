//
//  samImageView.swift
//  samTest
//
//  Created by Sam on 15/5/16.
//  Copyright (c) 2015年 Sam. All rights reserved.
//

import UIKit

let WIDTH = UIScreen.mainScreen().bounds.width
let HEIGHT = UIScreen.mainScreen().bounds.height

class samImageView: UIImageView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var imageArray:[UIImage] = []
    var currentTag = 0
    convenience init(frame: CGRect,image:UIImage,imageArray:[UIImage]) {
        self.init(frame: frame)
        self.userInteractionEnabled = true
        self.imageArray = imageArray
        var tagTouch = UITapGestureRecognizer(target: self, action: "zoomBig:")
        if let index = find(self.imageArray, image) {
        self.currentTag = index
        } else {
        self.currentTag = 0
        }
        self.image = self.imageArray[self.currentTag]
        self.addGestureRecognizer(tagTouch)
    }
    
    
    func zoomBig(sender:UITapGestureRecognizer){
        var window = UIApplication.sharedApplication().keyWindow
        var frame = CGRectMake(0, 0, WIDTH, HEIGHT)
        var scrollView = samImgScrollView(frame: frame, imagesArray: self.imageArray,currentPage:self.currentTag)
        window?.addSubview(scrollView)
        scrollView.userInteractionEnabled = true
        scrollView.alpha = 0
        
        var hide = UITapGestureRecognizer(target: self, action: "hideImg:")
        scrollView.addGestureRecognizer(hide)
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            var vsize = UIScreen.mainScreen().bounds.size
            scrollView.frame = CGRectMake(0, 0, vsize.width, vsize.height)
            scrollView.contentMode = UIViewContentMode.ScaleAspectFit
            scrollView.alpha = 1
        })
        
    }
    
    func hideImg(sender:UITapGestureRecognizer){
        if let view = sender.view {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                view.superview?.removeFromSuperview()
                view.removeFromSuperview()
                view.alpha = 0
            })
        }
        
    }
}
