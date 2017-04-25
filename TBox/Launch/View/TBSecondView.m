//
//  TBSecondView.m
//  TBox
//
//  Created by 王言 on 2017/4/25.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBSecondView.h"

@implementation TBSecondView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    NSLog(@"TBSecondView: x=%f,y=%f,w=%f,h=%f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
    
    return self;
}

@end
