//
//  ZIKTViperInteractorPrivate.h
//  ZIKTViper
//
//  Created by zuik on 2017/7/17.
//  Copyright © 2017 zuik. All rights reserved.
//

#import "ZIKTViperInteractor.h"

@protocol ZIKTViperInteractorPrivate <ZIKTViperInteractor>
- (void)setEventHandler:(id)eventHandler;
- (void)setDataSource:(id)dataSource;
@end
