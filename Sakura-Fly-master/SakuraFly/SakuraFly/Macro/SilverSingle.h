//
//  SilverSingle.h
//  测试时
//
//  Created by GalaxyRing on 16/1/13.
//  Copyright © 2016年 GalaxyRing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SilverSingle : NSObject
@property(nonatomic,copy)NSString *string;
@property(nonatomic,assign)BOOL is_Load;
+(SilverSingle *)shareSingle;
+(void)releaseSingle;


@end
