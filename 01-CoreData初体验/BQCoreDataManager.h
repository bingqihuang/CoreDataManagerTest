//
//  BQCoreDataManager.h
//  02CoreData框架探索
//
//  Created by huangbq on 2017/2/6.
//  Copyright © 2017年 huangbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
/**
 CoreData管理器
 */
@interface BQCoreDataManager : NSObject

+ (instancetype)shareManager;

/**
 持久化容器，可以管理上下文， iOS 10推出
 包含了 Core Data Stack 中所有的核心对象，但都不是线程安全的。
 
 - NSManagedObjectContext *viewContext;
 - NSManagedObjectModel *managedObjectModel;
 - NSPersistentStoreCoordinator *persistentStoreCoordinator;
 */
//@property(readonly, strong) NSPersistentContainer *persistentContainer;

/*
 管理上下文对象
 */
@property(readonly, strong) NSManagedObjectContext *managedObjectContext;

- (void)saveContext;

@end
