//
//  ZIKTEditorWireframeInput.h
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/24.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZIKTViperRouter;
@protocol ZIKTEditorWireframeInput <NSObject>
- (id<ZIKTViperRouter>)router;
@end
