//
//  ZIKEditorViewProtocol.h
//  testTemplate
//
//  Created by zuik on 2017/4/28.
//  Copyright © 2017 zuik. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ZIKEditorMode) {
    ZIKEditorModeCreate,
    ZIKEditorModeModify
};

@protocol ZIKEditorDelegate;
@protocol ZIKEditorViewProtocol <NSObject>
@property (nonatomic, weak) id<ZIKEditorDelegate> delegate;
@property (nonatomic, assign) ZIKEditorMode editMode;
- (nullable NSString *)titleString;
- (nullable NSString *)contentString;

- (void)updateTitleString:(NSString *)title;
- (void)updateContentString:(NSString *)content;
@end

NS_ASSUME_NONNULL_END
