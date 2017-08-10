//
//  ZIKTEditorViewController
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/16.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import "ZIKTEditorViewController.h"
@import ZIKTViper.ZIKTViperViewPrivate;
@import ZIKTViper.UIViewController_ZIKTViperRouter;

#import "ZIKTEditorViewEventHandler.h"
#import "ZIKTEditorViewDataSource.h"
#import "ZIKTTextWidgetViewProtocol.h"

#import "ZIKTTextView.h"
#import "ZIKTTextViewBuilder.h"

@interface ZIKTEditorViewController () <ZIKTViperViewPrivate,ZIKTTextViewDataSource>
@property (nonatomic, assign) BOOL appeared;
@property (nonatomic, strong) id<ZIKTEditorViewEventHandler> eventHandler;
@property (nonatomic, strong) id<ZIKTEditorViewDataSource> viewDataSource;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet ZIKTTextView<ZIKTTextWidgetViewProtocol> *contentTextView;
@end

@implementation ZIKTEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Editor";
    
    [ZIKTTextViewBuilder buildView:(id)self.contentTextView router:self.eventHandler.router];
    NSAssert([self.contentTextView conformsToProtocol:@protocol(ZIKTViperViewPrivate)], nil);
    
    self.contentTextView.dataSource = self;
    self.contentTextView.colorForCopyright = [UIColor grayColor];
}

- (UIViewController *)routeSource {
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.appeared == NO) {
        NSAssert([self.eventHandler conformsToProtocol:@protocol(ZIKTEditorViewEventHandler)], nil);
        UIBarButtonItem *addNoteItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                     target:self.eventHandler
                                                                                     action:@selector(didTouchNavigationBarDoneButton)];
        self.navigationItem.rightBarButtonItem = addNoteItem;
        
        //Note: in -viewWillAppear:, if this view controller contains sub routable UIView added from external (addSubview:, storyboard or xib), it may not be ready yet. The UIView has to search the UIViewController with -nextResponder to prepare itself, nextResponder can only be gained after -willMoveToWindow:. But -willMoveToWindow: may not be called yet in -viewWillAppear:. If the subview is not ready, config the subview in -handleViewReady may fail. If you can make sure there is no sub routable UIView or the subview is added with router before -viewWillAppear:, you can do -handleViewReady in -viewWillAppear:.
        if ([self.eventHandler respondsToSelector:@selector(handleViewReady)]) {
            [self.eventHandler handleViewReady];
        }
        self.appeared = YES;
    }
    if ([self.eventHandler respondsToSelector:@selector(handleViewWillAppear:)]) {
        [self.eventHandler handleViewWillAppear:animated];
    };
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([self.eventHandler respondsToSelector:@selector(handleViewDidAppear:)]) {
        [self.eventHandler handleViewDidAppear:animated];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.eventHandler respondsToSelector:@selector(handleViewWillDisappear:)]) {
        [self.eventHandler handleViewWillDisappear:animated];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if ([self.eventHandler respondsToSelector:@selector(handleViewDidDisappear:)]) {
        [self.eventHandler handleViewDidDisappear:animated];
    }
    if (self.ZIK_isRemoving == YES) {
        if ([self.eventHandler respondsToSelector:@selector(handleViewRemoved)]) {
            [self.eventHandler handleViewRemoved];
        }
    }
}

- (nullable NSString *)titleString {
    return self.titleTextField.text;
}

- (nullable NSString *)contentString {
    return self.contentTextView.text;
}

- (void)updateTitleString:(NSString *)title {
    self.titleTextField.text = title;
}

- (void)updateContentString:(NSString *)content {
    self.contentTextView.text = content;
}

#pragma mark ZIKTTextViewDataSource

- (NSString *)prefixStringForTextView:(ZIKTTextView *)textView {
    return [self.viewDataSource prefixStringForTextView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
