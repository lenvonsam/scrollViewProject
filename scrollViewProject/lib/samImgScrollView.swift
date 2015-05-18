//
//  samImgScrollView.swift
//  samTest
//
//  Created by Sam on 15/5/16.
//  Copyright (c) 2015年 Sam. All rights reserved.
//

import UIKit

class samImgScrollView: UIView,UIScrollViewDelegate {
    var backgroundScrollView:UIScrollView!
    var bottomLabel:UILabel!
    var pageControl:UIPageControl!
    var samImagesArray:[UIImage] = []
    var samImageViewsArray:[UIImageView?] = []
    var pageCount = 0
    var currentPageCount = 0
    
    convenience init(frame: CGRect,imagesArray:[UIImage],currentPage:Int) {
        self.init(frame:frame)
        self.samImagesArray = imagesArray
        self.pageCount = imagesArray.count
        self.currentPageCount = currentPage
        initConfig(self.frame)
        
    }
    
    func initConfig(frame:CGRect){
        //初始化scrollView
        backgroundScrollView = UIScrollView(frame: frame)
        backgroundScrollView.scrollEnabled = true
        backgroundScrollView.pagingEnabled = true
        backgroundScrollView.delegate = self
        backgroundScrollView.contentSize = CGSize(width: backgroundScrollView.frame.size.width*CGFloat(self.pageCount), height: backgroundScrollView.frame.size.height)
        backgroundScrollView.backgroundColor = UIColor.blackColor()
        
        //初始化imageView
        for img in self.samImagesArray {
            samImageViewsArray.append(nil)
        }
      
        self.addSubview(backgroundScrollView)
        
        pageControl = UIPageControl()
        var pageControlWidth = CGFloat(50)
        var pageControlHeight = CGFloat(20)
        var pageControlx = (WIDTH-pageControlWidth)/2
        var pageControly = HEIGHT-pageControlHeight-5
        pageControl.frame = CGRectMake(pageControlx, pageControly, pageControlWidth, pageControlHeight)
        self.addSubview(pageControl)
        pageControl.currentPage = self.currentPageCount
        pageControl.numberOfPages = self.pageCount
        

        
        //初始化提示标签
        bottomLabel = UILabel()
        bottomLabel.frame = CGRectMake(WIDTH-35, HEIGHT-25, 30, 20)
        bottomLabel.textColor = UIColor.whiteColor()
        
        self.addSubview(bottomLabel)
        
        var contextOffsetX = backgroundScrollView.frame.size.width*CGFloat(self.currentPageCount)
        self.backgroundScrollView.contentOffset = CGPoint(x: contextOffsetX, y: 0)

        initVisibleView()
    }
    
    func initVisibleView(){
        self.bottomLabel.text = "\(self.currentPageCount+1)/\(self.pageCount)"
        
        //前一页
        var prePageCount = currentPageCount - 1
        //后一页
        var nextPageCount = currentPageCount + 1
        
        for var index = 0; index < prePageCount; ++index {
            purgePage(index)
        }
        
        //加载需要加载的内容
        for index in prePageCount...nextPageCount {
            loadPage(index)
        }
        
        //无需加载自动清除
        for var index = nextPageCount+1; index<self.pageCount; index++ {
            purgePage(index)
        }
    }
    
    func loadPage(page:Int){
        if page>=0 && page<self.pageCount {
            loadImageView(page)
        }
    }
    
    func loadImageView(page:Int){
        if let imgView = self.samImageViewsArray[page] {
            //加载过的无需加载
        } else {
            var currentFrame = backgroundScrollView.frame
            currentFrame.origin.x = backgroundScrollView.bounds.width*CGFloat(page)
            
            var newImageView = UIImageView(image: self.samImagesArray[page])
            newImageView.alpha = 1
            newImageView.frame = currentFrame
            newImageView.contentMode = UIViewContentMode.ScaleAspectFit
            backgroundScrollView.addSubview(newImageView)
            
            self.samImageViewsArray[page] = newImageView
        }
    }
    
    func purgePage(page:Int){
        if let currentImageView = self.samImageViewsArray[page] {
            currentImageView.removeFromSuperview()
            self.samImageViewsArray[page] = nil
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var scrollViewWidth = scrollView.frame.size.width
        self.currentPageCount = Int(floor(scrollViewWidth+scrollView.contentOffset.x*2.0)/(scrollViewWidth*2.0))
        self.pageControl.currentPage = self.currentPageCount
        initVisibleView()
    }

}
