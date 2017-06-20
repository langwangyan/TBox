//
//  TBCenterTableViewCell.m
//  TBox
//
//  Created by 王言 on 2017/6/16.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBCenterTableViewCell.h"

@implementation TBCenterTableViewCell

- (TBCenterTableViewCell *)initCellWithID:(NSString *)ID tableView:(UITableView *)tableView {
    self = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (self==nil) {
        self = [[TBCenterTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleGray];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        
        [self.textLabel setFont:[UIFont systemFontOfSize:14]];
        [self.textLabel setTextColor:[UIColor blackColor]];
        
        self.rightLabel = [[UILabel alloc] init]; //定义一个在cell最右边显示的label
        self.rightLabel.font = [UIFont boldSystemFontOfSize:15];
        [self.rightLabel sizeToFit];
        self.rightLabel.backgroundColor = [UIColor clearColor];
        self.rightLabel.frame =CGRectMake(100,12, SCREEN_WIDTH-130, 23);
        [self.rightLabel setTextAlignment:NSTextAlignmentRight];
        self.rightLabel.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:self.rightLabel];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
