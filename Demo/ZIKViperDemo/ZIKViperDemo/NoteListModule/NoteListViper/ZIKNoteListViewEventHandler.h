//
//  ZIKNoteListViewEventHandler.h
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/16.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ZIKViper/ZIKViperViewEventHandler.h>

@protocol ZIKNoteListViewEventHandler <ZIKViperViewEventHandler,UIViewControllerPreviewingDelegate>
- (void)didTouchNavigationBarAddButton;
- (BOOL)canEditRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)handleDeleteCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)handleDidSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end
