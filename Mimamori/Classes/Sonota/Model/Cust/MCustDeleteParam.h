//
//  MCustDeleteParam.h
//  Mimamori
//
//  Created by 楊亜玲 on 16/11/1.
//  Copyright © 2016年 totyu3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCustDeleteParam : NSObject
/**
 使用者ID（見守る人）
 */
@property (nonatomic, copy) NSString                               *userid1;
/**
 入居者ID（見守られる人）
 */
@property (nonatomic, copy) NSString                               *userid0;

@end
