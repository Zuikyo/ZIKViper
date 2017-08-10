//
//  ZIKEditorDelegate.h
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/16.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZIKNoteModel;
@protocol ZIKEditorDelegate <NSObject>
- (void)editor:(UIViewController *)editor didFinishEditNote:(ZIKNoteModel *)note;
@end
