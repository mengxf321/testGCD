//
//  ViewController.m
//  testGCD
//
//  Created by jiang on 2019/4/2.
//  Copyright © 2019 klpy. All rights reserved.
//

#import "ViewController.h"
//666
@interface ViewController ()

@end
//制造问题
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addSubview4];
}

- (void)addSubview1
{
    //同步执行+并发队列
    NSLog(@"当前线程%@",[NSThread currentThread]);
    NSLog(@"syncConcurrent---begin");
    dispatch_queue_t queue = dispatch_queue_create("myGCDTest", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue
                  , ^{
                      
                      for (int i = 0; i < 2; i++){
                          
                          [NSThread sleepForTimeInterval:2];
                          NSLog(@"1------:%@",[NSThread currentThread]);
                      }
                      
                  });
    
    dispatch_sync(queue, ^{
       
        for (int i = 0; i < 2; i++){
            
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2------:%@",[NSThread currentThread]);
        }
        
    });
    
    dispatch_sync(queue, ^{
       
        for (int i = 0; i < 2; i++){
            
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3------:%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"syncConcurrent---end");
    
}

- (void)addSubview2
{
    //异步执行+并发队列
    NSLog(@"当前线程:%@",[NSThread currentThread]);
     NSLog(@"syncConcurrent---begin");
    dispatch_queue_t queue = dispatch_queue_create("myGCD", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
       
        for (int i = 0; i < 2; i++){
            
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1------:%@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; i++){
            
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2------:%@",[NSThread currentThread]);
        }
        
    });
    
    dispatch_async(queue, ^{
        
        for (int i = 0; i < 2; i++){
            
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3------:%@",[NSThread currentThread]);
        }
        
    });
    
    NSLog(@"syncConcurrent---end");
}

- (void)addSubview3
{
    //同步执行+主队列
    //主队列是串行队列
    NSLog(@"当前线程:%@",[NSThread currentThread]);
    NSLog(@"syncConcurrent---begin");
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_sync(queue, ^{
        
        for (int i = 0; i < 2; i++){
            
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1------:%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; i++){
            
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2------:%@",[NSThread currentThread]);
        }
        
    });
    
    dispatch_sync(queue, ^{
        
        for (int i = 0; i < 2; i++){
            
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3------:%@",[NSThread currentThread]);
        }
        
    });
    
    NSLog(@"syncConcurrent---end");
}

- (void)addSubview4
{
    //GCD线程间通信
    
    NSLog(@"当前线程:%@",[NSThread currentThread]);
    NSLog(@"syncConcurrent---begin");
    
    //获取全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
 
    //获取主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        //异步添加任务
        for (int i = 0; i < 2; i++){//进行耗时操作,下载数据,图片之类的
            
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1------:%@",[NSThread currentThread]);
        }
        
        //回到主线程
        dispatch_async(mainQueue, ^{//耗时操作完成之后,返回到主线程
            
            [NSThread sleepForTimeInterval:2];
            NSLog(@"2------:%@",[NSThread currentThread]);
        });
    });
    
    
    
    NSLog(@"syncConcurrent---end");
}


@end
