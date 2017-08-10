//
//  ZIKTEditorViewProtocol.h
//  testTemplate
//
//  Created by zuik on 2017/4/28.
//  Copyright © 2017年 zuik. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ZIKTEditorMode) {
    ZIKTEditorModeCreate,
    ZIKTEditorModeModify
};

@protocol ZIKTEditorDelegate;
@protocol ZIKTEditorViewProtocol <NSObject>
@property (nonatomic, weak) id<ZIKTEditorDelegate> delegate;
@property (nonatomic, assign) ZIKTEditorMode editMode;
- (nullable NSString *)titleString;
- (nullable NSString *)contentString;

- (void)updateTitleString:(NSString *)title;
- (void)updateContentString:(NSString *)content;
@end

NS_ASSUME_NONNULL_END
