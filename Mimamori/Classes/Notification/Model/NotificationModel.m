//
//  NotificationModel.m
//  Mimamori
//
//  Created by NISSAY IT on 2016/06/07.
//  Copyright © 2016年 NISSAY IT. All rights reserved.
//

#import "NotificationModel.h"


@implementation NotificationModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"groupid" : @"id",
             @"groupname" : @"name"
             };
}


@end
