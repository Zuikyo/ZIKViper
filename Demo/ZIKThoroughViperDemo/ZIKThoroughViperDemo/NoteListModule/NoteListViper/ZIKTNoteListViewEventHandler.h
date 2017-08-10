//
//  ZIKTNoteListViewEventHandler.h
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/16.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@import ZIKTViper.ZIKTViperViewEventHandler;

@protocol ZIKTNoteListViewEventHandler <ZIKTViperViewEventHandler,UIViewControllerPreviewingDelegate>
- (void)didTouchNavigationBarAddButton;

- (BOOL)canEditRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)handleDeleteCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)handleDidSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end
