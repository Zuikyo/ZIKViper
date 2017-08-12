# ZIKViper
iOS VIPER implementation, demonstrating discovering modules and injecting dependencies with protocol. Provide VIPER code Templates.

You can get answers about these discussions here:

* How to decouple modules thoroughly
* How to import a sub VIPER module
* How a sub module communicates with it's parent module
* How to inject dependencies to a module
* Interface-oriented router

---

两个iOS VIPER架构实现，关注于模块化和基于接口的依赖注入，并且提供快速生成VIPER代码的模板。

具体展示了以下问题的解决方案：

* 如何彻底地解决不同模块之间的耦合
* 如何在一个模块里引入子模块
* 子模块和父模块之间如何通信
* 如何对模块进行依赖注入
* 面向接口的路由工具

## [中文文档](https://github.com/Zuikyo/ZIKViper/blob/master/README-CN.md)

## Catalog

* [What's VIPER](#VIPER-intro)
* [Clean Architecture](#Clean-Architecture)
* [First Implementation: Thorough VIPER](#implementation1)
	* [View](#implementation1-view)
	* [Presenter](#implementation1-presenter)
	* [Interactor](#implementation1-interactor)
	* [Service](#implementation1-service)
	* [Wireframe](#implementation1-wireframe)
	* [Router](#implementation1-router)
	* [Adapter](#implementation1-adapter)
	* [Builder](#implementation1-builder)
* [Decoupling](#module-decoupling)
* [Submodule](#submodule)
	* [Source of Submodule](#submodule-source)
	* [Communication](#submodule-communication)
* [Refactor MVC](#map-to-mvc)
* [Second implementation: VIPER with ZIKRouter](#implementation2)
	* [View](#implementation2-view)
	* [Presenter](#implementation2-presenter)
	* [Interactor](#implementation2-interactor)
	* [Router](#implementation2-router-dependency-injection)
* [Demo and Templates](#demo-template)
* [Reference](#reference)

## <a name="VIPER-intro"></a>What's VIPER

The word VIPER is a backronym for:

* View
* Interactor
* Presenter
* Entity
* Router

A diagram for VIPER:

![VIPER](https://github.com/Zuikyo/ZIKViper/blob/master/Docs/viper.png)

(from [iOS Architecture Patterns: Demystifying MVC, MVP, MVVM and VIPER](https://medium.com/ios-os-x-development/ios-architecture-patterns-ecba4c38de52#.vm64nm3ro))

If it's new for you, check out these articles to learn VIPER architecture:

* [MEET VIPER: MUTUAL MOBILE’S APPLICATION OF CLEAN ARCHITECTURE FOR IOS APPS](https://mutualmobile.com/posts/meet-viper-fast-agile-non-lethal-ios-architecture-framework)
* [Architecting iOS Apps with VIPER](https://www.objc.io/issues/13-architecture/viper/)
* [Brigade’s Experience Using an MVC Alternative: VIPER architecture for iOS applications](https://brigade.engineering/brigades-experience-using-an-mvc-alternative-36ef1601a41f)
* [VIPER to be or not to be?](https://swifting.io/blog/2016/03/07/8-viper-to-be-or-not-to-be/)
* [VIPER architecture: Our best practices to build an app like a boss](https://cheesecakelabs.com/blog/best-practices-viper-architecture/)
* [The-Book-of-VIPER](https://github.com/strongself/The-Book-of-VIPER)

## <a name="Clean-Architecture"></a>Clean Architecture

[Mutual mobile](https://mutualmobile.com/posts/meet-viper-fast-agile-non-lethal-ios-architecture-framework) first came up with VIPER in 2013. VIPER is an application of `Clean Architecture`, so you have to know `Clean Architecture` before VIPER practice.

[Clean Architecture](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html) divides an app’s logical structure into distinct layers of responsibility. This makes it easier to isolate dependencies and to test the interactions at the boundaries between layers.

The diagram for Clean Architecture:

![Clean Architecture](https://github.com/Zuikyo/ZIKViper/blob/master/Docs/CleanArchitecture.jpg)

The key is the dependency rule:

>The Dependency Rule
>
The concentric circles represent different areas of software. In general, the further in you go, the higher level the software becomes. The outer circles are mechanisms. The inner circles are policies.
>
The overriding rule that makes this architecture work is The Dependency Rule. This rule says that source code dependencies can only point inwards. Nothing in an inner circle can know anything at all about something in an outer circle. In particular, the name of something declared in an outer circle must not be mentioned by the code in an inner circle. That includes, functions, classes. variables, or any other named software entity.

**Those components in VIPER conform to this dependency rule**.

## <a name="implementation1"></a>First Implementation: Thorough VIPER

I will give two implementations of VIPER here. The first is a thorough decoupled implementation. Then I will show another implementation, an easier one allowing some coupling.

The thorough implementation describes dependency injection, module communication, module decoupling. I add some new components.

Below is the diagram. The color of the component is corresponding to their color in the diagram of `Clean Architecture`:

![thorough viper](https://github.com/Zuikyo/ZIKViper/blob/master/Docs/thorough_viper.png)

I will use a note app as sample. 

### <a name="implementation1-view"></a>View

View can be a UIView + UIViewController, or a custom UIView, or a Manager of UIView, as long as it implement the interface of View.

Responsibilities:

* Assemble different view widgets, and manage their layout
* Provide `view input` interface to presenter for updating view state
* Send view events to `event handler` (the `presenter`)
* Get data for displaying views from `view dataSource` (the `presenter`)
* Provide `routeSource` to `presenter` as the source view controller for navigation

View will import many widgets and implements their delegates. View will wrap separate methods in these delegates into `ViewEventHandlerInput` and `ViewDataSourceInput` for different responsibilities.

`viewDataSource` and `viewEventHandler` stand for the two responsibilities of `presenter` for View.

Sample code:

```
@protocol ZIKNoteListViewEventHandler <NSObject>
- (void)handleDidSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end
```
```
@protocol ZIKNoteListViewDataSource <NSObject>
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSString *)textOfCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)detailTextOfCellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
```
```
@interface ZIKNoteListViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) id<ZIKNoteListViewEventHandler> eventHandler;
@property (nonatomic, strong) id<ZIKNoteListViewDataSource> viewDataSource;
@property (weak, nonatomic) IBOutlet UITableView *noteListTableView;
@end

@implementation ZIKNoteListViewController

- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath
                                      text:(NSString *)text
                                detailText:(NSString *)detailText {
    UITableViewCell *cell = [self.noteListTableView dequeueReusableCellWithIdentifier:@"noteListCell" forIndexPath:indexPath];
    cell.textLabel.text = text;
    cell.detailTextLabel.text = detailText;
    return cell;
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewDataSource numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = [self.viewDataSource textOfCellForRowAtIndexPath:indexPath];
    NSString *detailText = [self.viewDataSource detailTextOfCellForRowAtIndexPath:indexPath];
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath
                                                   text:text
                                             detailText:detailText];
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.eventHandler handleDidSelectRowAtIndexPath:indexPath];
}

@end
```

### <a name="implementation1-presenter"></a>Presenter

Presenter's responsibilities:

* Handle view event, interpreting to wireframe or interactor
* Provide view dataSource from interactor to view
* Update view by interfaces in `ViewInput`
* Maintain states of view
* Call use cases provided by interactor
* Handle interactor event
* Provide datas of view from view to interactor
* Show other view modules by wireframe

Presenter is a transfer station between view and interactor. It transforms different events to business logic. You shouldn't import `UIKit` in presenter to affect rendering of view directly.

Sample code:

```
@interface ZIKNoteListViewPresenter ()<ZIKNoteListViewEventHandler, ZIKNoteListViewDataSource>
@property (nonatomic, strong) id<ZIKNoteListWireframeProtocol> wireframe;
@property (nonatomic, weak) id<ZIKViperView,ZIKNoteListViewProtocol> view;
@property (nonatomic, strong) id<ZIKNoteListInteractorProtocol> interactor;
@end

@implementation ZIKNoteListViewPresenter

#pragma mark ZIKNoteListViewDataSource

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return self.interactor.noteCount;
}

- (NSString *)textOfCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = [self.interactor titleForNoteAtIndex:indexPath.row];
    return title;
}

- (NSString *)detailTextOfCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *content = [self.interactor contentForNoteAtIndex:indexPath.row];
    return content;
}

#pragma mark ZIKNoteListViewEventHandler

- (void)handleDidSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *uuid = [self.interactor noteUUIDAtIndex:indexPath.row];
    NSString *title = [self.interactor noteTitleAtIndex:indexPath.row];
    NSString *content = [self.interactor noteContentAtIndex:indexPath.row];
    
    [self.wireframe pushEditorViewForEditingNoteWithUUID:uuid title:title content:content delegate:self];
}

@end
```

### <a name="implementation1-interactor"></a>Interactor

Presenter's responsibilities:

* Provide different use cases for each business
* Maintain states of business logic
* Use different managers and services to implement the business, and these managers and services should be injected as dependencies, but not imported directly
* Maintain model through data manager
* Monitor and handle business events, and send event to `eventHandler` (the `presenter`) if necessary
* Get datas from `dataSource` (the `presenter`) to update the model

Most of the business logics is implemented in Interactor.

Sample code:

```
@protocol ZIKNoteListInteractorProtocol <NSObject>
- (void)loadAllNotes;
- (NSInteger)noteCount;
- (NSString *)titleForNoteAtIndex:(NSUInteger)idx;
- (NSString *)contentForNoteAtIndex:(NSUInteger)idx;
- (NSString *)noteUUIDAtIndex:(NSUInteger)idx;
- (NSString *)noteTitleAtIndex:(NSUInteger)idx;
- (NSString *)noteContentAtIndex:(NSUInteger)idx;
@end
```
```
@interface ZIKNoteListInteractor : NSObject <ZIKNoteListInteractorProtocol>
@property (nonatomic, weak) id dataSource;
@property (nonatomic, weak) id eventHandler;
@end
```
```
@implementation ZIKNoteListInteractor

- (void)loadAllNotes {
    [[ZIKNoteDataManager sharedInsatnce] fetchAllNotesWithCompletion:^(NSArray *notes) {
        [self.eventHandler didFinishLoadAllNotes];
    }];
}

- (NSArray<ZIKNoteModel *> *)noteList {
    return [ZIKNoteDataManager sharedInsatnce].noteList;
}

- (NSInteger)noteCount {
    return self.noteList.count;
}

- (NSString *)titleForNoteAtIndex:(NSUInteger)idx {
    if (self.noteList.count - 1 < idx) {
        return nil;
    }
    return [[self.noteList objectAtIndex:idx] title];
}

- (NSString *)contentForNoteAtIndex:(NSUInteger)idx {
    if (self.noteList.count - 1 < idx) {
        return nil;
    }
    return [[self.noteList objectAtIndex:idx] content];
}

- (NSString *)noteUUIDAtIndex:(NSUInteger)idx {
    if (self.noteList.count - 1 < idx) {
        return nil;
    }
    return [[self.noteList objectAtIndex:idx] uuid];
}

- (NSString *)noteTitleAtIndex:(NSUInteger)idx {
    if (self.noteList.count - 1 < idx) {
        return nil;
    }
    return [[self.noteList objectAtIndex:idx] title];
}

- (NSString *)noteContentAtIndex:(NSUInteger)idx {
    if (self.noteList.count - 1 < idx) {
        return nil;
    }
    return [[self.noteList objectAtIndex:idx] content];
}

@end
```

### <a name="implementation1-service"></a>Service

Service is a small unit providing specific functions, such as location service, log service. Manager is also a service here.

Services should be injected by application through `builder` when routing to this module. `Builder` will set services to interactor. You can also inject a service as a service router for providing other services, then you can lazy load a service.

A service can be considered as a VIPER module without `view` and `presenter`, it also has `router` and `builder`.

### <a name="implementation1-wireframe"></a>Wireframe

`Wireframe` is different with `router`. `Wireframe` describes the route from one module to another module. It provide route use cases to the presenter. So `wireframe` is an internal-facing interface inside a VIPER module. `Router` is responsible for fetching other modules and do real navigation works.

Those use cases in `wireframe` like segue in storyboard. A route use case will config the view and it's depencendies, such as transition animations.

Sample interface:

```
@interface ZIKTNoteListWireframe : NSObject <ZIKTViperWireframe>
- (void)presentLoginViewWithMessage:(NSString *)message delegate:(id<ZIKTLoginViewDelegate>)delegate completion:(void (^ __nullable)(void))completion;
- (void)dismissLoginView:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;
- (void)presentEditorForCreatingNewNoteWithDelegate:(id<ZIKTEditorDelegate>)delegate completion:(void (^ __nullable)(void))completion;
- (void)pushEditorViewForEditingNoteWithUUID:(NSString *)uuid title:(NSString *)title content:(NSString *)content delegate:(id<ZIKTEditorDelegate>)delegate;
- (UIViewController *)editorViewForEditingNoteWithUUID:(NSString *)uuid title:(NSString *)title content:(NSString *)content delegate:(id<ZIKTEditorDelegate>)delegate;
- (void)pushEditorViewController:(UIViewController *)destination fromViewController:(UIViewController *)source animated:(BOOL)animated;
- (void)quitEditorViewWithAnimated:(BOOL)animated;
@end
```

### <a name="implementation1-router"></a>Router

`Router` is responsible for fetching other modules and do real navigation works,  it's provided by the application.

A module doesn't know how the router discover another module, and how the router route to another module. Router is also responsible to inject dependencies with the `builder` of a module.

Sample code:

```
@interface ZIKTRouter : NSObject <ZIKTViperRouter>
///封装UIKit的跳转方法
+ (void)pushViewController:(UIViewController *)destination fromViewController:(UIViewController *)source animated:(BOOL)animated;
+ (void)popViewController:(UIViewController *)viewController animated:(BOOL)animated;
+ (void)presentViewController:(UIViewController *)viewControllerToPresent fromViewController:(UIViewController *)source animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;
+ (void)dismissViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;
@end

@implementation ZIKTRouter (ZIKTEditor)

+ (UIViewController *)viewForCreatingNoteWithDelegate:(id<ZIKTEditorDelegate>)delegate {
    return [ZIKTEditorBuilder viewForCreatingNoteWithDelegate:delegate];
}

+ (UIViewController *)viewForEditingNoteWithUUID:(NSString *)uuid title:(NSString *)title content:(NSString *)content delegate:(id<ZIKTEditorDelegate>)delegate {
    return [ZIKTEditorBuilder viewForEditingNoteWithUUID:uuid title:title content:content delegate:delegate];
}

@end
```

### <a name="implementation1-adapter"></a>Adapter

Adapter lives in application context. It's an interface adapter between different modules.

If `A` module use a `B1` protocol to call `B` module, but `B` module use another  `B2` protocol. `B1` protocol and `B2` protocol are about the same, but some interface names are a little different (such as `-editingNote:` to `-modifyNote:`), then the adapter can transfer `-editingNote:` to `-modifyNote:` in application context.

With the adapter, `A` module can be decoupled with the `B2` protocol, it's only has an dependency with `B` module's abstract interface.

Note: the adapter here is not the same with `Interface Adapter` layer in `Clean Architecture`. The adapter here is a real adapter component just for interface between modules. But `Interface Adapter` layer in `Clean Architecture` is more abstract. Read [Clean Architecture](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html) for detail.

### <a name="implementation1-builder"></a>Builder

`Builder` assembles those VIPER components, and declares this module's dependencies.

## <a name="module-decoupling"></a>Decoupling

A VIPER unit is an independent module can be encapsulated as a framework, imported by an app with a dependency manager like cocoapods. Then the app is responsible for linking those modules.

`Wireframe` -> `Router and Adapter` -> `Builder` shows the route from `A` module to `B` module.

`B` module can be replaced by `C` module, as long as `C` module provides same interface. Now `A` module is perfectly decoupled with `B` module.

In a real world, `wireframe` is like a plug, `builder` is like a socket, `router` and `adapter` are like wire and socket adapter.

## <a name="submodule"></a>Submodule

How to import a sub VIPER module? How multi modules communicate with each other?
Who is responsible for import and manage sub modules?

### <a name="submodule-source"></a>Source of Submodule

There're two sources of a submodule:

* View use a sub widget, and the widget is a VIPER module
* interactor use a service

### <a name="submodule-communication"></a>Communication

A submodule can be a UIView, or a child UIViewController, or a service. So the submodule may need dependencies, or it's totally independent and can do all the business inside it self.

If the submodule is independent, then there's no logic to communicate with other modules in the submodule. The submodule only exposts some event interface by `ModuleOutput`. Parent view will receive these event and send them to parent presenter, and the parent presenter doesn't know these event is from a sub view.

If a parent module need to call submodule's methods or get data from submodule, parent view or parent builder can set parent presenter or parent interactor to submodule's delegate. 

So, parent module and submodule doesn't really know each other, they only communicate through interface. Now, when view choose to replace the sub view with another sub view, code in presenter won't be affected. 

## <a name="map-to-mvc"></a>Refactor MVC

If you want to refactor a MVC module into a VIPER module, you can follow these steps:

* Tidy up code in controller, separate different code by different responsibilities with `pragma mark`
* Move methods to different files as components in VIPER. View, Presenter, Interactor can directly import and use their classes
* Decouple different components with interface

Below is the sample:

```
@implementation ViewController
//------View-------

//View's life cycle
#pragma mark View life

//Asemble views, and set layout
#pragma mark View config

//Interface for updating views
#pragma mark Update view

//View reqeust data for rendering from presenter
#pragma mark Request view data source

//Monitor and send view event to presenter
#pragma mark Send view event

//------Presenter-------

#pragma mark Handle view event

#pragma mark Wireframe

#pragma mark Provide view data source

#pragma mark Provide model data source

#pragma mark Handle business event

//------Interactor-------

//Send event to presenter
#pragma mark Send business event

#pragma mark Business use case

#pragma mark Request data for model

#pragma mark Manage model

@end
```

View states and businnes states are not here. those states are usually @property, so they can only be separated in @interface.

## <a name="implementation2"></a>Second implementation: VIPER with ZIKRouter

The first implementation is for thoroughly decoupling, but it greatly grows up the amount of code. Actually when in practice, we can leave some coupling.

We can use a mediator to reduce the code. And router is the best component to become a mediator.

Below is the diagram:

![final viper](https://github.com/Zuikyo/ZIKViper/blob/master/Docs/final_viper.png)

### <a name="implementation2-view"></a>View

* View can use router to import another sub view
* It's OK to directly let presenter implements some delegate of submodule
* View still can't see any model

### <a name="implementation2-presenter"></a>Presenter

* Presenter can directly use router
* Model can exist as arguments in interface between presenter and interactor or other module, but presenter can't import module's header to use the model
* Presenter still can't import UIKit to modify any UI object

### <a name="implementation2-interactor"></a>Interactor

* Some common service can be directly imported
* Interactor can use service router to get other services

### <a name="implementation2-router-dependency-injection"></a>Router

Router changes a lot comparing the first implementation. View, presenter and interactor can all use router. View can use view router to get sub view. Presenter can use view router to perform navigation. Interactor can use service router to get service.

So router in this implementation is `wireframe`, `router` and `builder` in first implementation.

But how to decouple modules now?

Let me introduce [ZIKRouter](https://github.com/Zuikyo/ZIKRouter). It's a interface-oriented router to let you get a module by it's protocol. So you still don't need to import other module's header, just need their interface. And ZIKRouter also supports adapter, you can use multi protocol to get the same module.

The sample code:

```
///editor view module's interface
@protocol NoteEditorProtocol <NSObject>
@property (nonatomic, weak) id<ZIKEditorDelegate> delegate;
- (void)constructForCreatingNewNote;
- (void)constructForEditingNote:(ZIKNoteModel *)note;
@end

@implementation ZIKNoteListViewPresenter

- (void)handleDidSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert([[self.view routeSource] isKindOfClass:[UIViewController class]], nil);
    
    //Transition to editor view. Get editor's router class with protocol, and prepare the editor view with the protocol.
    [ZIKViewRouterForConfig(@protocol(NoteEditorProtocol))
	     performWithConfigure:^(ZIKViewRouteConfiguration<NoteEditorProtocol> *config) {
	         //Route config
	         //Source view controller
	         config.source = self;
	         
	         //Transition type
	         config.routeType = ZIKViewRouteTypePush;
	         
	         //Router will config editor module with these arguments
	         config.delegate = self;
	         [config constructForCreatingNewNote];
	         
	         config.prepareForRoute = ^(id destination) {
	             //Prepare the destination before transition
	         };
	         config.routeCompletion = ^(id destination) {
	             //Transition completes
	         };
	         config.performerErrorHandler = ^(SEL routeAction, NSError * error) {
	             //Transition is failed
	         };
	     }];
}

@end
```

## <a name="demo-template"></a>Demo and Templates

There're two Demos for two implementations. You can compare their difference.

There're also Xcode file templates for quickly generating VIPER code. You can find them in the `Templates` folder. Copy those `XXX.xctemplate` folders to `~/Library/Developer/Xcode/Templates/`, then you can use them in Xcode `New->File->Template`.

## <a name="reference"></a>Reference

* [MEET VIPER: MUTUAL MOBILE’S APPLICATION OF CLEAN ARCHITECTURE FOR IOS APPS](https://mutualmobile.com/posts/meet-viper-fast-agile-non-lethal-ios-architecture-framework)
* [Architecting iOS Apps with VIPER](https://www.objc.io/issues/13-architecture/viper/)
* [Clean Architecture](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html)
* [Brigade’s Experience Using an MVC Alternative: VIPER architecture for iOS applications](https://brigade.engineering/brigades-experience-using-an-mvc-alternative-36ef1601a41f)
* [VIPER to be or not to be?](https://swifting.io/blog/2016/03/07/8-viper-to-be-or-not-to-be/)
* [VIPER architecture: Our best practices to build an app like a boss](https://cheesecakelabs.com/blog/best-practices-viper-architecture/)
* [The-Book-of-VIPER](https://github.com/strongself/The-Book-of-VIPER)
* [ENGINEERING THE ARCHITECTURE BEHIND UBER’S NEW RIDER APP](https://eng.uber.com/new-rider-app/)