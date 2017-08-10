//
//  ZIKEditorViewEventHandler.h
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/16.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ZIKViper/ZIKViperViewEventHandler.h>

@protocol ZIKEditorViewEventHandler <ZIKViperViewEventHandler>
- (void)didTouchNavigationBarDoneButton;
- (BOOL)previewing;
@end
