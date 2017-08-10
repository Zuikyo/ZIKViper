//
//  ZIKEditorViewController
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/16.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZIKViper/ZIKViperView.h>
#import "ZIKEditorViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZIKEditorDelegate;
@interface ZIKEditorViewController : UIViewController <ZIKViperView, ZIKEditorViewProtocol>
@property (nonatomic, weak) id<ZIKEditorDelegate> delegate;
@property (nonatomic, assign) ZIKEditorMode editMode;
@end

NS_ASSUME_NONNULL_END
