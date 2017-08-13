# ZIKViper
两个iOS VIPER架构实现，关注于模块化和基于接口的依赖注入，并且提供快速生成VIPER代码的模板。

具体展示了以下问题的解决方案：

* 如何彻底地解决不同模块之间的耦合
* 如何在一个模块里引入子模块
* 子模块和父模块之间如何通信
* 如何对模块进行依赖注入
* 面向接口的路由工具

---

## 目录

* [VIPER简介](#VIPER-intro)
	* [View](#VIPER-intro-view)
	* [Presenter](#VIPER-intro-presenter)
	* [Router](#VIPER-intro-router)
	* [Interactor](#VIPER-intro-interactor)
	* [Entity](#VIPER-intro-entity)
	* [和MVX的区别](#VIPER-intro-mvx)
	* [优点](#VIPER-intro-advantage)
* [起源](#origin)
* [Clean Architecture](#Clean-Architecture)
	* [Enterprise Business Rules](#Clean-Architecture-Enterprise-Business-Rules)
	* [Application Business Rules](#Clean-Architecture-Application-Business-Rules)
	* [Interface Adapters](#Clean-Architecture-Interface-Adapters)
	* [Frameworks & Drivers](#Clean-Architecture-Frameworks-Drivers)
	* [总结](#Clean-Architecture-summary)
* [方案一：最完整的VIPER](#implementation1)
	* [View](#implementation1-view)
	* [Presenter](#implementation1-presenter)
	* [Interactor](#implementation1-interactor)
	* [Service](#implementation1-service)
	* [Wireframe](#implementation1-wireframe)
	* [Router](#implementation1-router)
	* [Adapter](#implementation1-adapter)
	* [Builder](#implementation1-builder)
* [模块间解耦](#module-decoupling)
* [子模块](#submodule)
	* [子模块的来源](#submodule-source)
	* [通信方式](#submodule-communication)
* [依赖注入](#dependency-injection)
* [映射到MVC](#map-to-mvc)
* [方案二：允许适当耦合](#implementation2)
	* [View](#implementation2-view)
	* [Presenter](#implementation2-presenter)
	* [Interactor](#implementation2-interactor)
	* [路由和依赖注入](#implementation2-router-dependency-injection)
	* [总结](#implementation2-summary)
* [Demo和代码模板](#demo-template)
* [参考](#reference)

## <a name="VIPER-intro"></a>VIPER简介

VIPER的全称是`View-Interactor-Presenter-Entity-Router`。示意图如下：

![VIPER](https://github.com/Zuikyo/ZIKViper/blob/master/Docs/viper.png)

相比MVX架构，VIPER多出了两个东西：Interactor（交互器）和Router（路由）。

各部分职责如下：

### <a name="VIPER-intro-view"></a>View

* 提供完整的视图，负责视图的组合、布局、更新
* 向Presenter提供更新视图的接口
* 将View相关的事件发送给Presenter

### <a name="VIPER-intro-presenter"></a>Presenter

* 接收并处理来自View的事件
* 向Interactor请求调用业务逻辑
* 向Interactor提供View中的数据
* 接收并处理来自Interactor的数据回调事件
* 通知View进行更新操作
* 通过Router跳转到其他View

### <a name="VIPER-intro-router"></a>Router

* 提供View之间的跳转功能，减少了模块间的耦合
* 初始化VIPER的各个模块

### <a name="VIPER-intro-interactor"></a>Interactor

* 维护主要的业务逻辑功能，向Presenter提供现有的业务用例
* 维护、获取、更新Entity
* 当有业务相关的事件发生时，处理事件，并通知Presenter

### <a name="VIPER-intro-entity"></a>Entity

* 和Model一样的数据模型

### <a name="VIPER-intro-mvx"></a>和MVX的区别

VIPER把MVC中的Controller进一步拆分成了Presenter、Router和Interactor。和MVP中负责业务逻辑的Presenter不同，VIPER的Presenter的主要工作是在View和Interactor之间传递事件，并管理一些View的展示逻辑，主要的业务逻辑实现代码都放在了Interactor里。Interactor的设计里提出了"用例"的概念，也就是把每一个会出现的业务流程封装好，这样可测试性会大大提高。而Router则进一步解决了不同模块之间的耦合。所以，VIPER和上面几个MVX相比，多总结出了几个需要维护的东西：

* View事件管理
* 数据事件管理
* 事件和业务的转化
* 总结每个业务用例
* 模块内分层隔离
* 模块间通信

而这里面，还可以进一步细分一些职责。VIPER实际上已经把Controller的概念淡化了，这拆分出来的几个部分，都有很明确的单一职责，有些部分之间是完全隔绝的，在开发时就应该清晰地区分它们各自的职责，而不是将它们视为一个Controller。

### <a name="VIPER-intro-advantage"></a>优点

VIPER的特色就是职责明确，粒度细，隔离关系明确，这样能带来很多优点：

* 可测试性好。UI测试和业务逻辑测试可以各自单独进行。
* 易于迭代。各部分遵循单一职责，可以很明确地知道新的代码应该放在哪里。
* 隔离程度高，耦合程度低。一个模块的代码不容易影响到另一个模块。
* 易于团队合作。各部分分工明确，团队合作时易于统一代码风格，可以快速接手别人的代码。

## <a name="origin"></a>起源

VIPER架构，最初是2013年在MutualMobile的技术博客上，由Jeff Gilbert 和 Conrad Stoll 提出的。他们的博客网站有过一次迁移，原文地址已经失效，这是迁移后的博文：[MEET VIPER: MUTUAL MOBILE’S APPLICATION OF CLEAN ARCHITECTURE FOR IOS APPS](https://mutualmobile.com/posts/meet-viper-fast-agile-non-lethal-ios-architecture-framework)。

这是文章中提出的架构示意图：

![viper-mutualmobile](https://github.com/Zuikyo/ZIKViper/blob/master/Docs/viper_mutualmobile.png)

Wireframe可以看作是Router的另一种表达。可以看到，VIPER之间的关系已经很明确了。之后，作者在2014年在objc.io上发表了另一篇更详细的介绍文章：[Architecting iOS Apps with VIPER](https://www.objc.io/issues/13-architecture/viper/)。

在作者的第一篇文章里，阐述了VIPER是在接触到了Uncle Bob的[Clean Architecture](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html)后，对Clean Architecture的一次实践。因此，VIPER真正的源头应该是Clean Architecture。

## <a name="Clean-Architecture"></a>Clean Architecture

由Uncle Bob在2011年提出的`Clean Architecture`，是一个平台无关的抽象架构。想要详细学习的，可以阅读作者的原文：[Clean Architecture](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html)，翻译：[干净的架构The Clean Architecture](http://www.jdon.com/artichect/the-clean-architecture.html)。

它通过梳理软件中不同层之间的依赖关系，提出了一个自外向内，单向依赖的架构，如下图所示：

![Clean Architecture](https://github.com/Zuikyo/ZIKViper/blob/master/Docs/CleanArchitecture.jpg)

越靠近内层，越变得抽象，越接近设计的核心。越靠近外层，越和具体的平台和实现技术相关。内层的部分完全不知道外层的存在和实现方式，代码只能从外层向内层引用，目的是为了实现层与层之间的隔离。将不同抽象程度的层进行隔离，做到了把业务规则和具体实现分离开。你可以把外层看作是内层的delegate，外层只能通过内层提供的delegate接口来使用内层。

### <a name="Clean-Architecture-Enterprise-Business-Rules"></a>Enterprise Business Rules

代表了这个软件项目的业务规则。由数据实体体现，是一些可以在不同的程序应用之间共享的数据结构。

### <a name="Clean-Architecture-Application-Business-Rules"></a>Application Business Rules

代表了本应用所使用的一些业务规则。封装和实现了用到的业务功能，会将各种实体的数据结构转为在用例中传递的实体类，但是和具体的数据库技术或者UI无关。

### <a name="Clean-Architecture-Interface-Adapters"></a>Interface Adapters

接口适配层。将用例的规则和具体的实现技术进行抽象地对接，将用例中用到的实体类转为供数据库存储的格式或者供View展示的格式。类似于MVVM中把Model转为ViewModel供View显示。

右下角表示了接口适配层中不同模块间的通信方式。不同的模块在业务用例中产生关联和数据传递。Input、Output就是Use Case提供给外层的数据流动接口。

### <a name="Clean-Architecture-Frameworks-Drivers"></a>Frameworks & Drivers

库和驱动层，代表了选用的各种具体的实现技术，例如持久层使用SQLite还是Core Data，网络层使用NSURLSession、NSURLConnection还是AFNetworking等。

### <a name="Clean-Architecture-summary"></a>总结

可以看到，Clean Architecture里已经出现了Use Case、Interactor、Presenter等概念，它为VIPER的工程实现提供了设计思想，VIPER将它的设计转化成了具体的实现。VIPER里的各部分正是存在着由外向内的依赖，从外向内表现为：`View -> Presenter -> Interactor -> Entity`，`Wireframe`严格来说也是一类特殊的Use Case，用于不同模块之间通信，连接了不同的`Presenter`。

必须要记住的是，**VIPER架构是根据由外向内的依赖关系来设计的**。这句话是指导我们进行进一步设计和优化的关键。

## <a name="implementation1"></a>方案一：最完整的VIPER

首先总结出一个绝对标准的VIPER，各部分遵循隔离关系，同时考虑到依赖注入、子模块通信、模块间解耦等问题，将VIPER的各部分的职责变得更加明确，也新增了几个角色。示例图如下，各角色的颜色和Clean Architecture图中各层的颜色对应：

![thorough viper](https://github.com/Zuikyo/ZIKViper/blob/master/Docs/thorough_viper.png)

示例代码将用一个笔记应用作为演示。

### <a name="implementation1-view"></a>View

View可以是一个UIView + UIViewController，也可以只是一个custom UIView，也可以是一个自定义的用于管理UIView的Manager，只要它实现了View的接口就可以。

View层的职责：

* 展示界面，组合各种UIView，并在UIViewController内管理各种控件的布局、更新
* View对外暴露各种用于更新UI的接口，而自己不主动更新UI
* View持有一个由外部注入的eventHandler对象，将View层的事件发送给eventHandler
* View持有一个由外部注入的viewDataSource对象，在View的渲染过程中，会从viewDataSource获取一些用于展示的数据，viewDataSource的接口命名应该尽量和具体业务无关
* View向Presenter提供routeSource，也就是用于界面跳转的源界面

View层会引入各种自定义控件，这些控件有许多delegate，都在View层实现，统一包装后，再交给Presenter层实现。因为Presenter层并不知道View的实现细节，因此也就不知道这些控件的接口，Presenter层只知道View层统一暴露出来的接口。而且这些控件的接口在定义时可能会将数据获取、事件回调、控件渲染接口混杂起来，最具代表性的就是`UITableViewDataSource`里的`-tableView:cellForRowAtIndexPath:`。这个接口同时涉及到了`UITableViewCell`和渲染cell所需要的Model，是非常容易产生耦合的地方，因此需要做一次分解。应该在View的dataSource里定义一个从外部获取所需要的简单类型数据的方法，在`-tableView:cellForRowAtIndexPath:`里用获取到的数据渲染cell。示例代码：

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

一般来说，viewDataSource和eventHandler都是由Presenter来担任的，Presenter接收到dataSource请求时，从Interactor里获取并返回对应的数据。你也可以选择在View和Presenter之间用ViewModel来进行交互。

### <a name="implementation1-presenter"></a>Presenter

Presenter由View持有，它的职责有：

* 接收并处理来自View的事件
* 维护和View相关的各种状态和配置，比如界面是否使用夜间模式等
* 调用Interactor提供的Use Case执行业务逻辑
* 向Interactor提供View中的数据，让Interactor生成需要的Model
* 接收并处理来自Interactor的业务事件回调事件
* 通知View进行更新操作
* 通过Wireframe跳转到其他View

Presenter是View和业务之间的中转站，它不包含业务实现代码，而是负责调用现成的各种Use Case，将具体事件转化为具体业务。Presenter里不应该导入UIKit，否则就有可能入侵View层的渲染工作。Presenter里也不应该出现Model类，当数据从Interactor传递到Presenter里时，应该转变为简单的数据结构。

示例代码：

```
@interface ZIKNoteListViewPresenter () <ZIKNoteListViewDataSource, ZIKNoteListViewEventHandler>
@property (nonatomic, strong) id<ZIKNoteListWireframeProtocol> wireframe;
@property (nonatomic, weak) id<ZIKViperView,ZIKNoteListViewProtocol> view;
@property (nonatomic, strong) id<ZIKNoteListInteractorInput> interactor;
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

Ineractor的职责：

* 实现和封装各种业务的Use Case，供外部调用
* 维护和业务相关的各种状态，比如是否正在编辑笔记
* Interactor可以获取各种Manager和Service，用于组合实现业务逻辑，这些Manager和Service应该是由外部注入的依赖，而不是直接引用具体的类
* 通过DataManager维护Model
* 监听各种外部的业务事件并处理，必要时将事件发送给eventHandler
* Interactor持有一个由外部注入的eventHandler对象，将需要外部处理的业务事件发送给eventHandler，或者通过eventHandler接口对某些数据操作的过程进行回调
* Interactor持有一个由外部注入的dataSource对象，用于获取View上的数据，以更新Model

Interactor是业务的实现者和维护者，它会调用各种Service来实现业务逻辑，封装成明确的用例。而这些Service在使用时，也都是基于接口的，因为Interactor的实现不和具体的类绑定，而是由Application注入Interactor需要的Service。

示例代码：

```
@protocol ZIKNoteListInteractorInput <NSObject>
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
@interface ZIKNoteListInteractor : NSObject <ZIKNoteListInteractorInput>
@property (nonatomic, weak) id dataSource;
@property (nonatomic, weak) id eventHandler;
@end

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

向Interactor提供各种封装好的服务，例如数据库的访问、存储，调用定位功能等。Service由Application在执行路由时注入到Builder里，再由Buidler注入到Interactor里。也可以只注入一个Service Router，在运行时再通过这个Service Router懒加载需要的Service，相当于注入了一个提供Router功能的Service。

Service可以看作是没有View的VIPER，也有自己的路由和Builder。

### <a name="implementation1-wireframe"></a>Wireframe

翻译成中文叫线框，用于表达从一个Module到另一个Module的过程。虽然也是扮演者执行路由的角色，但是其实它和Router是有区别的。

Wireframe和storyboard中连接好的一个个segue类似，负责提供一系列具体的路由用例，这个用例里已经配置好了源界面和目的界面的一些依赖，包括转场动画、模块间传参等。Wireframe的接口是提供给模块内部使用的，它通过调用Router来执行真正的路由操作。

示例代码：

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

Router则是由Application提供的具体路由技术，可以简单封装UIKit里的那些跳转方法，也可以用URL Router来执行路由。但是一个模块是不需要知道app使用的是什么具体技术的。Router才是真正连接各个模块的地方。它也负责寻找对应的目的模块，并且通过Buidler进行依赖注入。

示例代码：

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

由Application实现，负责在模块通信时进行一些接口的转换，例如两个模块使用了相同业务功能的某个Service，使用的protocol实现一样，但是protocol名字不一样，就可以在路由时，在Adapter里进行一次转换。甚至只要定义的逻辑一样，依赖参数的名字和数据类型也可以允许不同。这样就能让模块不依赖于某个具体的protocol，而是依赖于protocol实际定义的依赖和接口。

注意这里的Adapter和Clean Architecture里的`Interface Adapter`是不一样的。这里的Adapter就是字面意义上的接口转换，而Clean Architecture里的`Interface Adapter`层更加抽象，是Use Case层与具体实现技术之间的转换，囊括了更多的角色。

### <a name="implementation1-builder"></a>Builder

负责初始化整个模块，配置VIPER之间的关系，并对外声明模块需要的依赖，让外部执行注入。

## <a name="module-decoupling"></a>模块间解耦

一个VIPER模块可以看做是一个独立的组件，可以被单独封装成一个库，被app引用。这时候，app就负责将各个模块连接起来，也就是图中灰色的`Application Context`部分。一个模块，肯定是存在于一个上下文环境中才能运行起来的。

`Wireframe` -> `Router` -> `Adapter` -> `Builder` 实现了一个完整的模块间路由，并且实现了模块间的解耦。

其中Wireframe和Builder是分别由引用者模块和被引用模块提供的，是两个模块的出口和入口，而Router和Adapter则是由模块的使用者——Application实现的。

当两个模块之间存在引用关系时，说明存在业务逻辑上的耦合，这种耦合是业务的一部分，是不可能消除的。我们能做的就是把耦合尽量交给模块调用者，由Application来提供具体的类，注入到各个模块之中，而模块内部只面向protocol即可。这样的话，被引用模块只要实现了相同的接口，就可以随时替换，甚至接口有一些差异时，只要被引用模块提供了相同功能的接口，也可以通过Adapter来做接口兼容转换，让引用者模块无需做任何修改。

Wireframe相当于插头，Builder相当于插座，而Router和Adapter相当于电路和转接头，将不同规格的插座和插头连接起来。把这些连接和适配的工作交给Application层，就能让两个模块实现各自独立。

## <a name="submodule"></a>子模块

大部分方案都没有讨论子模块存在的情况。在VIPER里如何引入另一个VIPER模块？多个模块之间如何交互？子模块由谁初始化、由谁管理？

其他几个实现中，只有Uber较为详细地讨论了子模块的问题。在Uber的Riblets架构里，子模块的Router被添加到父模块的Router，模块之间通过delegate和监听的方式进行通信。这样做会让模块间产生一定的耦合。如果子模块是由于父View使用了一个子View控件而被引入的，那么父Interactor就会在代码里多出一个子Interactor，这样就导致了View的实现方式影响了Interactor的实现。

### <a name="submodule-source"></a>子模块的来源

子模块的来源有：

* View引用了一个封装好的子View控件，连带着引入了子View的整个VIPER
* Interactor使用了一个Service

### <a name="submodule-communication"></a>通信方式

子View可能是一个UIView，也可能是一个Child UIViewController。因此子View有可能需要向外部请求数据，也可能独立完成所有任务，不需要依赖父模块。

如果子View可以独立，那在子模块里不会出现和父模块交互的逻辑，只有把一些事件通过Output传递出去的接口。这时只需要把子View的接口封装在父View的接口里即可，父Presenter和父Interactor是不知道父View提供的这几个接口是通过子View实现的。这样父模块就能接收到子模块的事件了，而且能够保持Interactor和Presenter、View之间从低到高的依赖关系。

如果父模块需要调用子模块的某些功能，或者从子模块获取数据，可以选择封装到父View的接口里，不过如果涉及到数据模型，并且不想让数据模型出现在View的接口中，可以把子Interactor作为父Interactor的一个Service，在引入子模块时，通过父Builder注入到父Interactor里，或者根据依赖关系解耦地再彻底一点，注入到父Presenter里，让父Presenter再把接口转发给父Interactor。这样子模块和父模块就能通过Service的形式进行通信了，而这时，父Interactor也不知道这个Service是来自子模块里的。

在这样的设计下，子模块和父模块是不知道彼此的存在的，只是通过接口进行交互。好处是父View如果想要更换为另一个相同功能的子View控件，就只需要在父View里修改，不会影响Presenter和Interactor。

## <a name="dependency-injection"></a>依赖注入

这个VIPER的设计是通过接口将各个部分组合在一起的，一个类需要设置很多依赖，例如Interactor需要依赖许多Service。这就涉及到了两个问题：

* 在哪里配置依赖
* 一个类怎么声明自己的依赖

在这个方案中，由Builder声明整个模块的依赖，然后在Builder内部为不同的类设置依赖，外部在注入依赖时，就不必知道内部是怎么使用这些依赖参数的。一个类如果有必需的依赖参数，可以直接在init方法里体现，对于那些非必需的依赖，可以通过暴露接口来声明。

如果需要动态注入，而不是在模块初始化时就配置所有的依赖，Builder也可以提供动态注入的接口。

## <a name="map-to-mvc"></a>映射到MVC

如果你需要把一个模块从MVC重构到VIPER，可以先按照这个步骤：

* 整理Controller中的代码，把不同职责的代码用pragma mark分隔好
* 整理好后，按照各部分的职责，将代码分散到VIPER的各个角色中，此时View、Presenter、Interactor之间可以直接互相引用
* 把View、Presenter、Interactor进行解耦，抽出接口，互相之间依赖接口进行交互

下面就是第一步里在Controller中可以分隔出的职责：

```
@implementation ViewController
//------View-------

//View的生命周期
#pragma mark View life

//View的配置，包括布局设置
#pragma mark View config

//更新View的接口
#pragma mark Update view

//View需要从model中获取的数据
#pragma mark Request view data source

//监控、接收View的事件
#pragma mark Send view event

//------Presenter-------

//处理View的事件
#pragma mark Handle view event

//界面跳转
#pragma mark Wireframe

//向View提供配置用的数据
#pragma mark Provide view data source

//提供生成model需要的数据
#pragma mark Provide model data source

//处理业务事件，调用业务用例
#pragma mark Handle business event

//------Interactor-------

//监控、接收业务事件
#pragma mark Send business event

//业务用例
#pragma mark Business use case

//获取生成model需要的数据
#pragma mark Request data for model

//维护model
#pragma mark Manage model

@end
```

这里缺少了View状态管理、业务状态管理等职责，因为这些状态一般都是@property，用pragma mark不能分隔它们，只能在@interface里声明的时候进行隔离。

## <a name="implementation2"></a>方案二：允许适当耦合

上面的方案是以最彻底的解耦为目标设计的，在实践中，如果真的完全按照这个设计，代码量的确不小。其实一些地方的耦合并不会引起多大问题，除非你的模块需要封装成通用组件供多个app使用，否则并不需要按照100%的解耦要求来编写。因此接下来我再总结一个稍微简化的方案，总结一下各部分可以在哪些地方出现耦合，哪些耦合不能出现。

在这个方案里，我使用了一个中介者来减少一部分代码，Router就是一个很适合成为中介者的角色。

架构图如下：

![final viper](https://github.com/Zuikyo/ZIKViper/blob/master/Docs/final_viper.png)

### <a name="implementation2-view"></a>View

* View可以直接通过Router引入另一个子View，不需要通过Presenter的路由来引入
* View中的一些delegate如果变化的可能性不大，可以直接让Presenter实现（例如`UITableViewDataSource`），不用再封装一遍后交给Presenter
* View不能出现Model类

### <a name="implementation2-presenter"></a>Presenter

* Presenter可以直接调用Router执行路由，不用再通过Wireframe封装一遍
* Presenter的接口参数中可以出现Model类，但是不能导入Model类的头文件并且使用Model类，只能用于参数传递
* Presenter中不建议导入UIKit，除非能保证不会使用那些会影响控件渲染的方法

### <a name="implementation2-interactor"></a>Interactor

* 一些app中常用的Service可以直接引入，不需要通过外部注入的方式来使用
* Interactor可以用一个Service Router来动态获取Service

### <a name="implementation2-router-dependency-injection"></a>路由和依赖注入

改变得最多的就是路由部分。View、Presenter和Interactor都可以使用路由来获取一些模块。View可以通过路由获取子View，Presenter可以通过路由获取其他View模块，Interactor可以通过路由获取Service。

在实现时，可以把Wireframe、Router、Builder整合到一起，全都放到Router里，Router由模块实现并提供给外部使用。类似于Brigade团队和Rambler&Co团队的实现。但是他们的实现都是直接在Router里引入其他模块的Router，这样会导致依赖混乱，更好的方式是通过一个中间人统一提供其他模块的接口。

我在这里造了个轮子，通过protocol来寻找需要的模块并执行路由，不用直接导入目的模块中的类，并且提供了Adapter的支持，可以让多个protocol指向同一个模块。这样就能避免模块间的直接依赖。

示例代码：

```
///editor模块的依赖声明
@protocol NoteEditorProtocol <NSObject>
@property (nonatomic, weak) id<ZIKEditorDelegate> delegate;
- (void)constructForCreatingNewNote;
- (void)constructForEditingNote:(ZIKNoteModel *)note;
@end

@implementation ZIKNoteListViewPresenter

- (void)handleDidSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert([[self.view routeSource] isKindOfClass:[UIViewController class]], nil);
    
    //跳转到编辑器界面；通过protocol获取对应的router类，再通过protocol注入依赖
    //App可以用Adapter把NoteEditorProtocol和真正的protocol进行匹配和转接
    [ZIKViewRouterForConfig(@protocol(NoteEditorProtocol))
	     performWithConfigure:^(ZIKViewRouteConfiguration<NoteEditorProtocol> *config) {
	         //路由配置
	         //跳转的源界面
	         config.source = [self.view routeSource];
	         //设置跳转方式，支持所有界面跳转类型
	         config.routeType = ZIKViewRouteTypePush;
	         //Router内部负责用获取到的参数初始化editor模块
	         config.delegate = self;
	         [config constructForEditingNote:[self.interactor noteAtIndex:indexPath.row]];
	         config.prepareForRoute = ^(id destination) {
	             //跳转前配置目的界面
	         };
	         config.routeCompletion = ^(id destination) {
	             //跳转结束处理
	         };
	         config.performerErrorHandler = ^(SEL routeAction, NSError * error) {
	             //跳转失败处理
	         };
	     }];
}

@end
```

### <a name="implementation2-summary"></a>总结

这个方案依赖于一个统一的中间人，也就是路由工具，在我的实现里就是[ZIKRouter](https://github.com/Zuikyo/ZIKRouter)。View、Presenter、Interactor都可以使用对应功能的Router获取子模块。而由于ZIKRouter仍然是通过protocol的方式来和子模块进行交互，因此仍然可保持模块间解耦。唯一的耦合就是各部分都引用了ZIKRouter这个工具。如果你想把模块和ZIKRouter的耦合也去除，可以让Router也变成面向接口，由外部注入。

## <a name="demo-template"></a>Demo和代码模板

针对两个方案，同时写了两个相同功能的Demo，可以比较一下代码上的区别。项目里也提供了Xcode File Template用于快速生成VIPER代码模板。把`.xctemplate`后缀的文件夹拷贝到`~/Library/Developer/Xcode/Templates/`目录下，就可以在Xcode的`New->File->Template`里选择代码模板快速生成代码。

## <a name="reference"></a>参考

* [MEET VIPER: MUTUAL MOBILE’S APPLICATION OF CLEAN ARCHITECTURE FOR IOS APPS](https://mutualmobile.com/posts/meet-viper-fast-agile-non-lethal-ios-architecture-framework)
* [Architecting iOS Apps with VIPER](https://www.objc.io/issues/13-architecture/viper/)
* [Clean Architecture](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html)
* [Brigade’s Experience Using an MVC Alternative: VIPER architecture for iOS applications](https://brigade.engineering/brigades-experience-using-an-mvc-alternative-36ef1601a41f)
* [VIPER to be or not to be?](https://swifting.io/blog/2016/03/07/8-viper-to-be-or-not-to-be/)
* [VIPER architecture: Our best practices to build an app like a boss](https://cheesecakelabs.com/blog/best-practices-viper-architecture/)
* [The-Book-of-VIPER](https://github.com/strongself/The-Book-of-VIPER)
* [ENGINEERING THE ARCHITECTURE BEHIND UBER’S NEW RIDER APP](https://eng.uber.com/new-rider-app/)