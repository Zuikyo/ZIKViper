//
//  ZIKEditorViewPresenter
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/16.
//  Copyright © 2017 zuik. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <ZIKViper/ZIKViperPresenter.h>
#import "ZIKEditorViewEventHandler.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZIKEditorViewPresenter : NSObject <ZIKViperPresenter,ZIKEditorViewEventHandler>
@property (nonatomic, assign) BOOL previewing;
@end

NS_ASSUME_NONNULL_END
