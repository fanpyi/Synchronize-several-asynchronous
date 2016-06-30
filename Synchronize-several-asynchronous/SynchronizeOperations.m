//
//  SynchronizeOperations.m
//  Synchronize-several-asynchronous
//
//  Created by fanpyi on 30/6/2016.
//  Copyright © 2016 fanpyi. All rights reserved.
//

#import "SynchronizeOperations.h"
#import "LoadImage.h"
@implementation SynchronizeOperations
+(void)synchronizeSynchronousLoadImages:(NSArray<NSString *> *)urls completedAllOperations:(CompletedAllOperations)completed{
    dispatch_group_t group = dispatch_group_create();
    NSMutableArray *images = @[].mutableCopy;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (NSString *url in urls) {
        dispatch_group_async(group, queue, ^{
            NSData *data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:url]];
            UIImage *image = [[UIImage alloc]initWithData:data];
            if (image) {
                 [images addObject:image];
            }
        });
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (completed) {
            completed(images);
        }
    });
   
}
+(void)synchronizeAsynchronousLoadImages:(NSArray<NSString *> *)urls completedAllOperations:(CompletedAllOperations)completed{
    dispatch_group_t group = dispatch_group_create();
    NSMutableArray *images = @[].mutableCopy;
    for (NSString *url in urls) {
        dispatch_group_enter(group);
        LoadImage *load = [[LoadImage alloc]init];
        [load downloadImageWithURL:url completed:^(UIImage *image, NSInteger imageSize, NSError *error, NSString *url) {
            if (image) {
                 [images addObject:image];
            }
            dispatch_group_leave(group);
        }];
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (completed) {
            completed(images);
        }
    });
}
+(void)synchronizeAsynchronousUsingBarrierLoadImages:(NSArray<NSString *> *)urls completedAllOperations:(CompletedAllOperations)completed{
    dispatch_queue_t queue = dispatch_queue_create("com.synchronize.loadimage", 0);
    NSMutableArray *images = @[].mutableCopy;
    for (NSString *url in urls) {
        dispatch_async(queue, ^{
            NSData *data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:url]];
            UIImage *image = [[UIImage alloc]initWithData:data];
            if (image) {
                [images addObject:image];
            }
        });
    }
    dispatch_barrier_async(queue, ^{
        if (completed) {
            completed(images);
        }
    });

    
}
@end
