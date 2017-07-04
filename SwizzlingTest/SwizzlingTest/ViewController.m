//
//  ViewController.m
//  SwizzlingTest
//
//  Created by Michalis Mavris on 05/07/2017.
//  Copyright © 2017 Miksoft. All rights reserved.
// https://github.com/mavris/Medium.com/tree/master/SwizzlingTest/SwizzlingTest

#import "ViewController.h"
#import "NSUserDefaults+MyUserDefaults.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSUserDefaults standardUserDefaults] setObject:@"An Object" forKey:@"Key"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
