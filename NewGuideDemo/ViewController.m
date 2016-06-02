//
//  ViewController.m
//  NewGuideDemo
//
//  Created by mkmy on 16/5/30.
//  Copyright © 2016年 mkmy_baoyu. All rights reserved.
//

#import "ViewController.h"
#import "ByGuideWindow.h"



@interface ViewController ()

@property (nonatomic, strong) UIImageView *showImgView;

@property (nonatomic, assign)  int runNum;

@property (nonatomic, assign) BOOL myBool;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.pageNum) {
        self.pageNum = 1;
    }
    
    //1.设置标题
    [self setPageTitle];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //2.首次打开弹出
    [self showGuideWindow];
    
    
}

#pragma mark - function
- (void)setPageTitle{
    self.title = [NSString stringWithFormat:@"这是第%zd页",self.pageNum];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    ViewController *VC = [[ViewController alloc] init];
    VC.pageNum = self.pageNum + 1;
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)showGuideWindow{
    
    [ByGuideWindow creatAnimationGuideWindowByKey:self.title withArrayTitle:@"guidePhoneCase" withImgesWith:nil withAlpha:1];
    
}



@end
