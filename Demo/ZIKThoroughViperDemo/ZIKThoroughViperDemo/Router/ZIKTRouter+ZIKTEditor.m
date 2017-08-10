//
//  ZIKTRouter+ZIKTEditor.m
//  ZIKTViperDemo
//
//  Created by zuik on 2017/8/2.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import "ZIKTRouter+ZIKTEditor.h"
#import "ZIKTEditorBuilder.h"

@implementation ZIKTRouter (ZIKTEditor)

+ (UIViewController *)viewForCreatingNoteWithDelegate:(id<ZIKTEditorDelegate>)delegate {
    return [ZIKTEditorBuilder viewForCreatingNoteWithDelegate:delegate router:[self new]];
}

+ (UIViewController *)viewForEditingNoteWithUUID:(NSString *)uuid title:(NSString *)title content:(NSString *)content delegate:(id<ZIKTEditorDelegate>)delegate {
    return [ZIKTEditorBuilder viewForEditingNoteWithUUID:uuid title:title content:content delegate:delegate router:[self new]];
}

@end
