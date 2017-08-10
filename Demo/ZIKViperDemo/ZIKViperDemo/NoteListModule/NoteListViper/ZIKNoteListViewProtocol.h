//
//  ZIKNoteListViewProtocol.h
//  testTemplate
//
//  Created by zuik on 2017/4/28.
//  Copyright © 2017 zuik. All rights reserved.
//
#import <Foundation/Foundation.h>

#define _ZIKNoteListViewProtocol_ (Protocol<ZIKRoutableViewDynamicGetter> *)@protocol(ZIKNoteListViewProtocol)
@protocol ZIKNoteListViewProtocol <NSObject>
- (UITableView *)noteListTableView;
@end
