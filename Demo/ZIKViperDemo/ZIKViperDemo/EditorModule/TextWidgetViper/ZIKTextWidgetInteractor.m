//
//  ZIKTextWidgetInteractor.m
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/17.
//  Copyright © 2017 zuik. All rights reserved.
//

#import "ZIKTextWidgetInteractor.h"
#import <ZIKViper/ZIKViperInteractorPrivate.h>
#import "ZIKTextWidgetInteractorDataSource.h"
#import "ZIKTextWidgetInteractorEventHandler.h"

@interface ZIKTextWidgetInteractor () <ZIKViperInteractorPrivate>
@property (nonatomic, copy) NSString *loginedAccount;
@end

@implementation ZIKTextWidgetInteractor

- (NSString *)copyrightDescription {
    return @"© This is ZIKTextView.";
}

- (BOOL)needValidateAccount {
    return self.loginedAccount == nil;
}

- (void)didLoginedWithAccount:(NSString *)account {
    self.loginedAccount = account;
}

@end
