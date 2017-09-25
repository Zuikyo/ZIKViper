//
//  NoteEditorDelegate.h
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/24.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NoteEditorDelegate <NSObject>
- (void)editor:(UIViewController *)editor didFinishEditNoteModel:(id)note;
@end
