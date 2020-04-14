//
//  ShareView.h
//
//  Created by 王双贵 on 2020/4/2.
//  Copyright © 2020 王双贵. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareView : UIView
//  点击按钮block回调
@property (nonatomic,copy) void(^btnClick)(NSInteger);

//  头部提示文字
@property (nonatomic,copy) NSString *proStr;

//  设置弹窗背景蒙板灰度(0~1)
@property (nonatomic,assign) CGFloat duration;

/**
 *  初始化
 *
 *  @param titleArray 标题数组
 *  @param imageArray 图片数组(如果不需要的话传空数组(@[])进来)
 *  @param proTitle   最顶部的标题  不需要的话传@""
 *
 *  @return ShareView
 */

- (instancetype)initWithShareHeadOprationWith:(NSArray *)titleArray andImageArry:(NSArray *)imageArray andProTitle:(NSString *)proTitle;
@end

NS_ASSUME_NONNULL_END
