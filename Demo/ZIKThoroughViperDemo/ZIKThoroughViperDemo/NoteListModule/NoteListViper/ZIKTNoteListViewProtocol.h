//
//  ZIKTNoteListViewProtocol.h
//  testTemplate
//
//  Created by zuik on 2017/4/28.
//  Copyright © 2017年 zuik. All rights reserved.
//
#import <Foundation/Foundation.h>

#define _ZIKTNoteListViewProtocol_ (Protocol<ZIKTRoutableViewDynamicGetter> *)@protocol(ZIKTNoteListViewProtocol)
@protocol ZIKTNoteListViewProtocol <NSObject>
- (UITableView *)noteListTableView;
- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath
                                      text:(NSString *)text
                                detailText:(NSString *)detailText;
@end
