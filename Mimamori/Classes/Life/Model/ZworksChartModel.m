//
//  ZworksChartModel.m
//  Mimamori
//
//  Created by totyu3 on 16/6/14.
//  Copyright © 2016年 totyu3. All rights reserved.
//

#import "ZworksChartModel.h"

@implementation ZworksChartModel

//在这个方法说清楚
//1.哪些属性需要归档
//2.怎样存储这些属性

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:_picpath forKey:@"picpath"];
    [aCoder encodeObject:_deviceid forKey:@"deviceid"];
    [aCoder encodeObject:_devicename forKey:@"devicename"];
    [aCoder encodeObject:_deviceunit forKey:@"deviceunit"];
    [aCoder encodeObject:_latestvalue forKey:@"latestvalue"];
    [aCoder encodeObject:_devicevalues forKey:@"devicevalues"];
    [aCoder encodeObject:_batterystatus forKey:@"batterystatus"];
//    [aCoder encodeObject:_subdeviceinfo forKey:@"subdeviceinfo"];
    
}



//在这个方法说清楚
//1.哪些属性需要解析（读取）
//2.怎样解析（读取）这些属性

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        _picpath = [aDecoder decodeObjectForKey:@"picpath"];
        _deviceid = [aDecoder decodeObjectForKey:@"deviceid"];
        _devicename = [aDecoder decodeObjectForKey:@"devicename"];
        _deviceunit = [aDecoder decodeObjectForKey:@"deviceunit"];
        _latestvalue = [aDecoder decodeObjectForKey:@"latestvalue"];
        _devicevalues = [aDecoder decodeObjectForKey:@"devicevalues"];
        _batterystatus = [aDecoder decodeObjectForKey:@"batterystatus"];
//        _subdeviceinfo = [aDecoder decodeObjectForKey:@"subdeviceinfo"];
        
       
    }
    return self;
}

@end
