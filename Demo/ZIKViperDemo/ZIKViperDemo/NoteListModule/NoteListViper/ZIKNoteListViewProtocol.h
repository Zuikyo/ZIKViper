//
//  ZIKNoteListViewProtocol.h
//  testTemplate
//
//  Created by zuik on 2017/4/28.
//  Copyright © 2017 zuik. All rights reserved.
//
#import <Foundation/Foundation.h>
@import ZIKRouter;

#define _ZIKNoteListViewProtocol_ (Protocol<ZIKViewRoutable> *)@protocol(ZIKNoteListViewProtocol)
@protocol ZIKNoteListViewProtocol <ZIKViewRoutable>
- (UITableView *)noteListTableView;
@end
