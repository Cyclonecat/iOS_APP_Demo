//
//  mapLocation.m
//  简单定位
//
//  Created by 刘蘩 on 15/12/1.
//  Copyright © 2015年 刘蘩. All rights reserved.
//

#import "mapLocation.h"

@implementation mapLocation
#pragma mark 标点上的主标题
- (NSString *)title{
    return @"您的位置!";
}

#pragma  mark 标点上的副标题
- (NSString *)subtitle{
    NSMutableString *ret = [NSMutableString new];
    if (_state) {
        [ret appendString:_state];
    }
    if (_city) {
        [ret appendString:_city];
    }
    if (_city && _state) {
        [ret appendString:@", "];
    }
    if (_streetAddress && (_city || _state || _zip)) {
        [ret appendString:@" · "];
    }
    if (_streetAddress) {
        [ret appendString:_streetAddress];
    }
    if (_zip) {
        [ret appendFormat:@",  %@",_zip];
    }
    return ret;
}
@end
