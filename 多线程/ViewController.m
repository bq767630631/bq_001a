//
//  ViewController.m
//  多线程
//
//  Created by 包强 on 2018/1/27.
//  Copyright © 2018年 包强. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSThread *threadA;
@property (nonatomic, strong) NSThread *threadB;
@property (nonatomic, strong) NSThread *threadC;
@property (nonatomic, assign) NSInteger totalCount;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.totalCount = 100;
    NSLog(@"xxoo");
     NSLog(@"xxoo");
     NSLog(@"xxoo");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), queue, ^{
        NSLog(@"%@", [NSThread currentThread]);
    });
//    [self downloadImage];
   // [self synSERIAL];
   // [NSThread detachNewThreadSelector:@selector(asynConcurrent) toTarget:self withObject:nil];
//    [self asynSERIAL];
    
}

- (void)downloadImage
{
     CFTimeInterval start = CFAbsoluteTimeGetCurrent();
    NSURL *url = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1517048628227&di=b9da5e8f1ea14ebd32245fdc632d2ede&imgtype=0&src=http%3A%2F%2Fwww.pp3.cn%2Fuploads%2F201603%2F20160320016.jpg"];
   
    NSData *data = [NSData dataWithContentsOfURL:url];
       CFTimeInterval end = CFAbsoluteTimeGetCurrent();
    NSLog(@"end-start %.f  end %.f ",end-start, end);
    UIImage *image = [UIImage imageWithData:data];
//    self.imageView.image = image;
    [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
}

- (void)asynConcurrent
{
    dispatch_queue_t quene = dispatch_queue_create("com.bq.download", DISPATCH_QUEUE_SERIAL);
    //quene = dispatch_get_main_queue();
    NSLog(@"start --  %@",[NSThread currentThread]);
    dispatch_async(quene, ^{
        NSLog(@"down1 %@", [NSThread currentThread]);
    });
    dispatch_async(quene, ^{
        NSLog(@"down2%@", [NSThread currentThread]);
    });
    dispatch_async(quene, ^{
        NSLog(@"down3%@", [NSThread currentThread]);
    });
    dispatch_async(quene, ^{
        NSLog(@"down4%@", [NSThread currentThread]);
    });
    
     NSLog(@"end --  %@",[NSThread currentThread]);
}


- (void)synSERIAL
{
    dispatch_queue_t quene = dispatch_queue_create("com.bq.download", DISPATCH_QUEUE_CONCURRENT);
    
   NSLog(@"start--%@", [NSThread currentThread]);
    dispatch_sync(quene, ^{
        NSLog(@"down1 %@", [NSThread currentThread]);
    });
    dispatch_sync(quene, ^{
        NSLog(@"down2%@", [NSThread currentThread]);
    });
    dispatch_sync(quene, ^{
        NSLog(@"down3%@", [NSThread currentThread]);
    });
    dispatch_sync(quene, ^{
        NSLog(@"down4%@", [NSThread currentThread]);
    });
    NSLog(@"end--%@", [NSThread currentThread]);
}



@end
