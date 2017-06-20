//
//  TBCenterTableViewCell.h
//  TBox
//
//  Created by 王言 on 2017/6/16.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol TBCenterTableViewCellDelegate <NSObject>
//
//@optional
//
//-(void) changeRightLabel:(NSString *)text;
//
//@end

@interface TBCenterTableViewCell : UITableViewCell

- (TBCenterTableViewCell *)initCellWithID:(NSString *)ID tableView:(UITableView *)tableView;

@property(nonatomic,strong) UILabel *rightLabel;

//@property(nonatomic,weak) id<TBCenterTableViewCellDelegate> delegate;

@end
