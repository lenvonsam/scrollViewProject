//
//  ViewController.swift
//  scrollViewProject
//
//  Created by Sam on 15/5/18.
//  Copyright (c) 2015年 Sam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var imagesArray:[UIImage] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //初始化图片
        var image1 = UIImage(named: "1.jpg")!
        var image2 = UIImage(named: "2.jpg")!
        var image3 = UIImage(named: "3.jpg")!
        var image4 = UIImage(named: "4.jpg")!
        imagesArray = [image1,image2,image3,image4]
        
        //设置samImageView在view中的位置
        initConfig()
    }
    
    func initConfig(){
        var imageWidth = CGFloat(100)
        var imageHeight = CGFloat(100)
        var initX = CGFloat((WIDTH-imageWidth*3)/4)
        for var index=0; index<imagesArray.count; index++ {
            var tempView:samImageView!
            if index<3 {
            var imageY = initX
            var para1 = CGFloat(index + 1)
            var imageX = initX*para1 + imageWidth*CGFloat(index)
            var currentFrame = CGRectMake(imageX, imageY, imageWidth, imageHeight)
            tempView = samImageView(frame: currentFrame, image: imagesArray[index], imageArray: imagesArray)
            self.view.addSubview(tempView)
            } else {
            var imageY = initX*CGFloat(2)+imageHeight
            var para1 = initX*CGFloat(index-2)
            var para2 = imageWidth*CGFloat(index-3)
            var imageX = para1+para2
            var currentFrame = CGRectMake(imageX, imageY, imageWidth, imageHeight)
            tempView = samImageView(frame: currentFrame, image: imagesArray[index], imageArray: imagesArray)
            self.view.addSubview(tempView)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

