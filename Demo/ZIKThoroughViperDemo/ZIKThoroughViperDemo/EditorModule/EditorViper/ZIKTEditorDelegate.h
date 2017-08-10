//
//  ZIKTEditorDelegate.h
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/16.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZIKTNoteModel;
@protocol ZIKTEditorDelegate <NSObject>
- (void)editor:(UIViewController *)editor didFinishEditNote:(ZIKTNoteModel *)note;
@end
