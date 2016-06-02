//
//  ByGuideWindow.m
//  NewGuideDemo
//
//  Created by mkmy on 16/5/31.
//  Copyright © 2016年 mkmy_baoyu. All rights reserved.
//

#import "ByGuideWindow.h"
#import "UIImage+GIF.h"


@interface ByGuideWindow ()

@property (nonatomic, strong) UIImageView *showImgView;

@property (nonatomic, assign) BOOL myBool;

@property (nonatomic, assign) int runNum;

@property (nonatomic, strong) NSTimer *myAnimatedTimer;

@property (nonatomic, copy) NSString *myTitle;


@end

@implementation ByGuideWindow


+ (void)creatGuideWindowByKey:(NSString *)key withImgeViewWith:(NSString *)imgStr withAlpha:(CGFloat)alpha{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:key]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
        ByGuideWindow *window = [self sharedInstance];
        [window addImgeViewWith:imgStr withAlpha:alpha];
        [window show];
    }
}

+ (void)creatGuideWindowByKey:(NSString *)key withGifImgeViewWith:(NSString *)imgStr withAlpha:(CGFloat)alpha{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:key]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
        ByGuideWindow *window = [self sharedInstance];
        [window addGifImgeViewWith:imgStr withAlpha:alpha];
        [window show];
    }
}


+ (void)creatGuideWindowByKey:(NSString *)key withImgesWith:(NSArray *)images withAlpha:(CGFloat)alpha{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:key]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
        ByGuideWindow *window = [self sharedInstance];
        [window addImgsWith:images];
        [window show];
    }
}


+ (void)creatAnimationGuideWindowByKey:(NSString *)key withArrayTitle:(NSString *)titlte withImgesWith:(NSArray *)images withAlpha:(CGFloat)alpha{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:key]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 1; i<=20; i++) {
            [array addObject:[NSString stringWithFormat:@"%@%d",titlte,i]];
        }
        ByGuideWindow *window = [self sharedInstance];
        [window addAnimationImagesWith:images withArrayTitle:titlte withAlpha:alpha];
        [window show];
    }
}


- (void)addAnimationImagesWith:(NSArray *)images withArrayTitle:(NSString *)title withAlpha:(CGFloat)alpha{
    self.showImgView = [[UIImageView alloc] initWithFrame:self.frame];
    [self.showImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesAction:)]];
    self.showImgView.userInteractionEnabled = YES;
    self.myTitle = title;
    self.myBool = YES;
    self.runNum = 1;
    [self.rootViewController.view addSubview:self.showImgView];
    self.myAnimatedTimer = [NSTimer scheduledTimerWithTimeInterval:0.035 target:self selector:@selector(setNextNewImage) userInfo:nil repeats:YES];
}

- (void)setNextNewImage{
    
    if (self.runNum==21) {
        self.myBool = NO;
    }
    if (self.runNum == 1) {
        self.myBool = YES;
    }
    if (self.myBool) {
        self.showImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d.jpg",self.myTitle,self.runNum]];
        self.runNum ++;
    }else{
        self.runNum --;
        self.showImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d.jpg",self.myTitle,self.runNum]];
    }
}

- (void)addImgsWith:(NSArray *)array{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.frame];
    [imgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesAction:)]];
    imgView.userInteractionEnabled = YES;
    imgView.animationDuration = 0.25;
    imgView.animationRepeatCount = 0;
    
    imgView.animationImages = array;
    [imgView startAnimating];
    [self.rootViewController.view addSubview:imgView];
}



- (void)addImgeViewWith:(NSString *)imgStr withAlpha:(CGFloat)alpha{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.frame];
    imgView.alpha = alpha;
    [imgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesAction:)]];
    imgView.userInteractionEnabled = YES;
    imgView.image = [UIImage imageNamed:imgStr];
    for (UIView *view in self.rootViewController.view.subviews) {
        [view removeFromSuperview];
    }
    [self.rootViewController.view addSubview:imgView];
    
}


- (void)addGifImgeViewWith:(NSString *)imgStr withAlpha:(CGFloat)alpha{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.frame];
    imgView.alpha = alpha;
    [imgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesAction:)]];
    imgView.userInteractionEnabled = YES;
    imgView.image = [UIImage sd_animatedGIFNamed:imgStr];
    
    for (UIView *view in self.rootViewController.view.subviews) {
        [view removeFromSuperview];
    }
    [self.rootViewController.view addSubview:imgView];
}


- (void)tapGesAction:(UITapGestureRecognizer *)tap{
    [self goBack];
}

#pragma mark - function
+ (ByGuideWindow *)sharedInstance{
    static ByGuideWindow *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
        UIViewController *Vc = [[UIViewController alloc] init];
        shareInstance.rootViewController = Vc;
    });
    return shareInstance;
}

- (void)goBack{
    [self resignKeyWindow];
    self.hidden = YES;
    for (UIView *view in self.rootViewController.view.subviews) {
        [view removeFromSuperview];
    }
    [self.myAnimatedTimer invalidate];
    self.myAnimatedTimer = nil;
}

- (void)show{
    [self makeKeyAndVisible];
    self.hidden = NO;
}

@end
