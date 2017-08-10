//
//  ZIKTEditorViewController
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/16.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import <UIKit/UIKit.h>
@import ZIKTViper.ZIKTViperView;
#import "ZIKTEditorViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZIKTEditorDelegate;
@interface ZIKTEditorViewController : UIViewController <ZIKTViperView, ZIKTEditorViewProtocol>
@property (nonatomic, weak) id<ZIKTEditorDelegate> delegate;
@property (nonatomic, assign) ZIKTEditorMode editMode;
@end

NS_ASSUME_NONNULL_END
