//
//  SynchronizeOperations.h
//  Synchronize-several-asynchronous
//
//  Created by fanpyi on 30/6/2016.
//  Copyright © 2016 fanpyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^CompletedAllOperations)(NSArray<UIImage *>* images);
@interface SynchronizeOperations : NSObject
+(void)synchronizeAsynchronousLoadImages:(NSArray<NSString *> *)urls  completedAllOperations:(CompletedAllOperations)completed;
+(void)synchronizeSynchronousLoadImages:(NSArray<NSString *> *)urls  completedAllOperations:(CompletedAllOperations)completed;
+(void)synchronizeAsynchronousUsingBarrierLoadImages:(NSArray<NSString *> *)urls completedAllOperations:(CompletedAllOperations)completed;
@end