//
//  MXView.m
//  TestPod
//
//  Created by maRk on 16/12/1.
//  Copyright © 2016年 maRk. All rights reserved.
//

#import "MXView.h"

@implementation MXView

+ (instancetype)getView
{
    return [[MXView alloc] init];
}

- (instancetype)init
{
    if (self = [super init]) {
        UISwitch *sw = [[UISwitch alloc] init];
        self.backgroundColor = [UIColor redColor];
        [self addSubview:sw];
    }
    return self;
}
@end
