//
//  LoadImage.h
//  SDwebimage-demo
//
//  Created by fanpyi on 29/6/2016.
//  Copyright © 2016 fanpyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^LoadImageCompleted)(UIImage *image,NSInteger imageSize,NSError *error,NSString *url);
@interface LoadImage : NSObject
@property(nonatomic,assign)NSInteger imageSize;
-(void)downloadImageWithURL:(NSString *)url  completed:(LoadImageCompleted)completed;
@end
