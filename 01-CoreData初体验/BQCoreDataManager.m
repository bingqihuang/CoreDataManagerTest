//
//  BQCoreDataManager.m
//  02CoreData框架探索
//
//  Created by huangbq on 2017/2/6.
//  Copyright © 2017年 huangbq. All rights reserved.
//

#import "BQCoreDataManager.h"

@implementation BQCoreDataManager

+ (instancetype)shareManager
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    
    return instance;
}

#pragma mark Core Data Stack

// 重写了只读属性的getter方法，编译器不再提供 _成员变量
@synthesize managedObjectContext = _managedObjectContext;

/*
 为了10.0以下版本兼容
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    // 互斥锁，锁定的代码应该尽量少
    @synchronized (self) {
        
        // 实例化管理上下文
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        // 管理对象模型(实体)
        NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        // 持久化存储调度器
        NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        
        // 添加数据库
        /**
         1> 数据存储类型
         2> 保存 SQLite 数据库文件的 URL
         3> 设置数据库选项,实现数据迁移
         
         注意！ 不要修改数据库的属性名称，也不要修改表格属性的类型，这些工作应该在设计表格时就要考虑好！
         */
        NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
        
        NSString *path = [cacheDir stringByAppendingPathComponent:@"test.db"];
        
        
        NSURL *url = [NSURL URLWithString:path];
        
        // 设置后，增删表格属性，都会自动刷新
        NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @(YES),
                                  NSInferMappingModelAutomaticallyOption: @(YES)};
        [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:options error:NULL];
        
        // 给管理上下文指定调度器,非常重要
        _managedObjectContext.persistentStoreCoordinator = coordinator;
    }
    return _managedObjectContext;
}

//@synthesize persistentContainer = _persistentContainer;
//
//- (NSPersistentContainer *)persistentContainer
//{
//    // 同步锁/互斥锁，保证线程安全。
//    @synchronized (self) {
//        
//        if (_persistentContainer == nil) {
//            
//            // 1.实例化对象，需要指定数据模型
//            // 这个只能实例化一个模型
////            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"demo_db"];
//            
//            // 合并所有的数据模型
//            NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
//            
//            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"test.db" managedObjectModel:model];
//            
//            // 2. ‘同步’  加载‘持久化存储’ -》创建数据库 -》打开、新建、修改数据库
//            // SQLite 'open db' 打开/新建数据库
//            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
//                
//                if (error) {
//                    NSLog(@"打开/新建数据库错误：%@ %@", error, error.userInfo);
//                    
//                    _persistentContainer = nil;
//                }
//            }];
//            
//            NSLog(@"加载数据库完成");
//        }
//        
//    }
//    
//    return _persistentContainer;
//}

#pragma mark Core Data Saving Support
- (void)saveContext {
    NSManagedObjectContext *context = self.managedObjectContext;
    
    // 判断上下文中是否有数据发生变化
    // `事务` 可以保存多个数据，不一定每次数据变化都需要保存，例如：for 增加多条记录，就可以最后调用一次保存操作即可！
    if (![context hasChanges]) {
        return;
    }
    
    // 保存数据
    NSError *error = nil;
    if (![context save:&error]) {
        
        NSLog(@"保存数据出错！ %@, %@", error, error.userInfo);
     
    }
}

@end
