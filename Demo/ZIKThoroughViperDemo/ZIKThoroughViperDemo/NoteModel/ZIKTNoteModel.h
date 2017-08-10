//
//  ZIKTNoteModel.h
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/16.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZIKTNoteModel : NSObject <NSCoding>
@property (nonatomic, readonly, copy) NSString *uuid;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *content;
- (instancetype)initWithUUID:(NSString *)uuid title:(NSString *)title content:(NSString *)content NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithNewNoteForTitle:(NSString *)title content:(NSString *)content;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
@end

NS_ASSUME_NONNULL_END
