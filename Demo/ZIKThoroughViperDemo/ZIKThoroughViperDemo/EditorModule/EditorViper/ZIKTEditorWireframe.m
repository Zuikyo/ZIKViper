//
//  ZIKTEditorWireframe.m
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/24.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import "ZIKTEditorWireframe.h"
@import ZIKTViper.ZIKTViperWireframePrivate;
@import ZIKTViper.ZIKTViperView;

@interface ZIKTEditorWireframe () <ZIKTViperWireframePrivate>
@property (nonatomic, weak) id<ZIKTViperView> view;
@property (nonatomic, strong) id<ZIKTViperRouter> router;
@end

@implementation ZIKTEditorWireframe

@end
