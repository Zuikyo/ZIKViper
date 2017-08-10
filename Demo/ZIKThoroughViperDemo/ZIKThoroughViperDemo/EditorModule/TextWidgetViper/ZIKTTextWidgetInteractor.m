//
//  ZIKTTextWidgetInteractor.m
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/17.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import "ZIKTTextWidgetInteractor.h"
@import ZIKTViper.ZIKTViperInteractorPrivate;
#import "ZIKTTextWidgetInteractorDataSource.h"
#import "ZIKTTextWidgetInteractorEventHandler.h"

@interface ZIKTTextWidgetInteractor () <ZIKTViperInteractorPrivate>
@property (nonatomic, copy) NSString *loginedAccount;
@end

@implementation ZIKTTextWidgetInteractor

- (NSString *)copyrightDescription {
    return @"© This is ZIKTTextView.";
}

- (BOOL)needValidateAccount {
    return self.loginedAccount == nil;
}

- (void)didLoginedWithAccount:(NSString *)account {
    self.loginedAccount = account;
}

@end
