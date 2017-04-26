//
//  XNGuideView.h
//
//  Created by LuohanCC on 15/11/30.
//  Copyright © 2015年 罗函. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBFirstView : UIView
+ (void)showGudieView:(NSArray *)imageArray;
//跳过引导(用在退出登陆时清理数据后加上这句,防止APP在退出登陆时删除了沙盒中的gudie标志后再次进入引导页)
+ (void)skipGuide;
- (instancetype)init:(NSArray *)imageArray;
@end
