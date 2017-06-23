//
//  MNoticeDateParam.h
//  Mimamori
//
//  Created by 楊亜玲 on 16/11/1.
//  Copyright © 2016年 totyu3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNoticeDateParam : NSObject

/**
 スタッフID（見守る人）
 */
@property (nonatomic, copy) NSString *staffid;


/**
 施設コード
 */
@property (nonatomic, copy) NSString *facilitycd;

@end
