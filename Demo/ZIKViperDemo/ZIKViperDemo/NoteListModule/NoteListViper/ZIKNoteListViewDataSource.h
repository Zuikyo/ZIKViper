//
//  ZIKNoteListViewDataSource.h
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/26.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZIKNoteListViewDataSource <NSObject>
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSString *)textOfCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)detailTextOfCellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
