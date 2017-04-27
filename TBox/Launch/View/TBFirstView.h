//
//  TBFirstView.h
//  TBox
//
//  Created by 王言 on 2017/4/25.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBFirstView : UIView
+ (void)showGudieView:(NSArray *)imageArray;
//跳过引导(用在退出登陆时清理数据后加上这句,防止APP在退出登陆时删除了沙盒中的gudie标志后再次进入引导页)
+ (void)skipGuide;
- (instancetype)init:(NSArray *)imageArray;
@end
