//
//  MSensorDataTool.m
//  Mimamori
//
//  Created by 楊亜玲 on 16/11/2.
//  Copyright © 2016年 totyu3. All rights reserved.
//

#import "MSensorDataTool.h"
#import "MHttpTool.h"

@implementation MSensorDataTool

+(void)sensorDataWithParam:(MSensorDataParam *)param type:(MSensorDataType)type success:(void (^)(NSArray *array))success failure:(void (^)(NSError *error))failure{
    NSString *url;
    switch (type) {
            
        case MSensorDataTypeDaily:
            url = NITGetDailyDeviceInfo;
            break;
        case MSensorDataTypeWeekly:
            url = NITGetWeeklyDeviceInfo;
            break;
        case MSensorDataTypeMontyly:
            url = NITGetMonthlyDeviceInfo;
            break;
        default:
            break;
    }
    [MHttpTool postWithURL:url params:param.mj_keyValues success:^(id json) {
        if (success) {
            NSArray *tmpArray = [json objectForKey:@"deviceinfo"];
            success(tmpArray);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


@end
