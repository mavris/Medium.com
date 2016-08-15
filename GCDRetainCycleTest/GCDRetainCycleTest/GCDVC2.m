//
//  GCDVC.m
//  GCDRetainCycleTest
//
//  Created by Michael Mavris on 26/07/16.
//  Copyright © 2016 Miksoft. All rights reserved.
//

#import "GCDVC2.h"

typedef void(^CustomBlock)(void);

@interface GCDVC2 ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,strong)NSMutableArray *proArray;
@property (nonatomic, copy) CustomBlock addObjectsBlock;
@property (nonatomic, copy) CustomBlock postGCDBlock;
@end

@implementation GCDVC2


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.proArray = [[NSMutableArray alloc]init];
    
    self.postGCDBlock = ^{
        
        [self.proArray removeObject:@"3"]; //At this line Xcode will warn you that this line is likely to lead on a retain cycle
        NSLog(@"%@",self.proArray);
        [self.activityIndicator stopAnimating];
    };
    
    self.addObjectsBlock = ^{
        
        [self.proArray addObject:@"2"]; //At this line Xcode will warn you that this line is likely to lead on a retain cycle
        [self.proArray addObject:@"3"];
        [NSThread sleepForTimeInterval:10];
        
        dispatch_async(dispatch_get_main_queue(),self.postGCDBlock);
    };
}


//The final solution without retain cycle
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    self.proArray = [[NSMutableArray alloc]init];
//    
//    GCDVC2* __weak weakSelf = self;
//
//    
//    self.postGCDBlock = ^{
//        
//        GCDVC2* __strong strongSelf = weakSelf;
//
//        [strongSelf.proArray removeObject:@"3"];
//        NSLog(@"%@",strongSelf.proArray);
//        [strongSelf.activityIndicator stopAnimating];
//    };
//    
//    self.addObjectsBlock = ^{
//        
//        GCDVC2* __strong strongSelf = weakSelf;
//        
//        [strongSelf.proArray addObject:@"2"];
//        [strongSelf.proArray addObject:@"3"];
//        [NSThread sleepForTimeInterval:5];
//        
//        dispatch_async(dispatch_get_main_queue(),^{
//            strongSelf.postGCDBlock();
//        });
//
//    };
//    
//}


- (IBAction)startGCDRetainCycle:(id)sender {
    
    [self.activityIndicator startAnimating];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), self.addObjectsBlock);
    
}

@end
