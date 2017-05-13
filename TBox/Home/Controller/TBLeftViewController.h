//
//  TBLeftViewController.h
//  TBox
//
//  Created by 王言 on 2017/4/26.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TBLeftViewControllerDelegate <NSObject>

@optional
-(void) pushVC:(UIViewController *)leftSonVC;

@end

@interface TBLeftViewController : UIViewController

@property(nonatomic,weak) id<TBLeftViewControllerDelegate> delegate;

@end

