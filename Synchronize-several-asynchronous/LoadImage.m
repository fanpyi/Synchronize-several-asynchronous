//
//  LoadImage.m
//  SDwebimage-demo
//
//  Created by fanpyi on 29/6/2016.
//  Copyright © 2016 fanpyi. All rights reserved.
//

#import "LoadImage.h"
#import "SDWebImage/SDWebImageManager.h"
@implementation LoadImage
-(void)downloadImageWithURL:(NSString *)url completed:(LoadImageCompleted)completed{
    NSURL *URL = [NSURL URLWithString:url];
    [[SDWebImageManager sharedManager]downloadImageWithURL:URL options:SDWebImageProgressiveDownload  progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.imageSize = expectedSize;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (error) {
            if (completed) {
                completed(nil,self.imageSize,error,url);
            }
        }else{
            if (completed && finished) {
                completed(image,self.imageSize,error,url);
            }
        }
        
    }];
}
@end
