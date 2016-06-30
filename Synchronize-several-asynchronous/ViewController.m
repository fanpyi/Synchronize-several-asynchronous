//
//  ViewController.m
//  Synchronize-several-asynchronous
//
//  Created by fanpyi on 30/6/2016.
//  Copyright © 2016 fanpyi. All rights reserved.
//

#import "ViewController.h"
#import "SynchronizeOperations.h"
@interface ViewController ()

@end

@implementation ViewController
-(NSArray<NSString *> *)urls{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"imageurl" ofType:@"txt"];
    NSString *ts = [[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    return [ts componentsSeparatedByString:@"\n"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SynchronizeOperations synchronizeAsynchronousLoadImages:[self urls] completedAllOperations:^(NSArray<UIImage *> *images) {
        NSLog(@"images=%@",images);
    }];
    [SynchronizeOperations synchronizeSynchronousLoadImages:[self urls] completedAllOperations:^(NSArray<UIImage *> *images) {
        NSLog(@"images=%@",images);
    }];
    [SynchronizeOperations synchronizeAsynchronousUsingBarrierLoadImages:[self urls] completedAllOperations:^(NSArray<UIImage *> *images) {
        NSLog(@"images=%@",images);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
