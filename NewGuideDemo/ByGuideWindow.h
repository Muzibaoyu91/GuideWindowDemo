//
//  ByGuideWindow.h
//  NewGuideDemo
//
//  Created by mkmy on 16/5/31.
//  Copyright © 2016年 mkmy_baoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ByGuideWindow : UIWindow


//根据沙盒的key值判断是否初始实例化

//加普通的一张照片
+ (void)creatGuideWindowByKey:(NSString *)key withImgeViewWith:(NSString *)imgStr withAlpha:(CGFloat)alpha;

//加Gif的一张照片
+ (void)creatGuideWindowByKey:(NSString *)key withGifImgeViewWith:(NSString *)imgStr withAlpha:(CGFloat)alpha;

//用animationImages来做
+ (void)creatGuideWindowByKey:(NSString *)key withImgesWith:(NSArray *)images withAlpha:(CGFloat)alpha;

//用定时器来做
+ (void)creatAnimationGuideWindowByKey:(NSString *)key withArrayTitle:(NSString *)titlte withImgesWith:(NSArray *)images withAlpha:(CGFloat)alpha;



// 单例初始化
+ (ByGuideWindow *)sharedInstance;

// 添加图片
- (void)addImgeViewWith:(NSString *)imgStr withAlpha:(CGFloat)alpha;

// 添加gif图片
- (void)addGifImgeViewWith:(NSString *)imgStr withAlpha:(CGFloat)alpha;

// 显示
- (void)show;

@end
