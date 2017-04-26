//
//  TBIndexView.m
//  TBox
//
//  Created by 王言 on 2017/4/26.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBIndexView.h"

@implementation TBIndexView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setBackgroundColor:[UIColor redColor]];
    
    NSLog(@"TBIndexView: x=%f,y=%f,w=%f,h=%f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
    
    return self;
}

@end
