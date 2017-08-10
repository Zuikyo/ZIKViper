//
//  ZIKTNoteModel.m
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/16.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import "ZIKTNoteModel.h"

@interface ZIKTNoteModel ()
@property (nonatomic, copy) NSString *uuid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@end

@implementation ZIKTNoteModel

- (instancetype)initWithUUID:(NSString *)uuid title:(NSString *)title content:(NSString *)content {
    NSParameterAssert(uuid.length > 0);
    NSParameterAssert(title);
    NSParameterAssert(content);
    if (self = [super init]) {
        _uuid = uuid;
        _title = title;
        _content = content;
    }
    return self;
}

- (instancetype)initWithNewNoteForTitle:(NSString *)title content:(NSString *)content {
    return [self initWithUUID:[NSUUID UUID].UUIDString title:title content:content];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.uuid forKey:@"uuid"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.content forKey:@"content"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self.uuid = [aDecoder decodeObjectForKey:@"uuid"];
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.content = [aDecoder decodeObjectForKey:@"content"];
    return self;
}

@end
