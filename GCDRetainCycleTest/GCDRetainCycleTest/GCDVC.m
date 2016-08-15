//
//  GCDVC.m
//  GCDRetainCycleTest
//
//  Created by Michael Mavris on 26/07/16.
//  Copyright © 2016 Miksoft. All rights reserved.
//

#import "GCDVC.h"

@interface GCDVC ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,strong)NSMutableArray *proArray;
@end

@implementation GCDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.proArray = [[NSMutableArray alloc]init];
}
- (IBAction)startGCD:(id)sender {
    
    GCDVC* __weak weakSelf = self;
    
    [self.activityIndicator startAnimating];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{ // 1
        
        // VC2* __strong strongSelf = weakSelf;
        
        [self.proArray addObject:@"2"];
        [self.proArray addObject:@"3"];
        [NSThread sleepForTimeInterval:10];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{ // 2
            [self.proArray removeObject:@"3"];
            NSLog(@"%@",self.proArray);
            [self.activityIndicator stopAnimating];
        });
    });
    
}

@end
