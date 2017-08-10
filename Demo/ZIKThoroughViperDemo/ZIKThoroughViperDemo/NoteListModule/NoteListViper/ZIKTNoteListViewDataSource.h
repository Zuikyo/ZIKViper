//
//  ZIKTNoteListViewDataSource.h
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/26.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZIKTNoteListViewDataSource <NSObject>
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSString *)textOfCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)detailTextOfCellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
