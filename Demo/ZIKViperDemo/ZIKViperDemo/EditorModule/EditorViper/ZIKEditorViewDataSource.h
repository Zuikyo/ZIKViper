//
//  ZIKEditorViewDataSource.h
//  ZIKthoroughViperDemo
//
//  Created by zuik on 2017/8/3.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZIKEditorViewDataSource <NSObject>
- (NSString *)prefixStringForTextView;
@end
