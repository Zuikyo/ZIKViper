//
//  ZIKViperInteractorPrivate.h
//  ZIKViper
//
//  Created by zuik on 2017/7/17.
//  Copyright © 2017 zuik. All rights reserved.
//

#import "ZIKViperInteractor.h"

@protocol ZIKViperInteractorPrivate <ZIKViperInteractor>
- (void)setEventHandler:(id)eventHandler;
- (void)setDataSource:(id)dataSource;
@end
