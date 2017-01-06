//
//  AppDelegate.h
//  01-CoreData初体验
//
//  Created by huangbq on 2017/1/6.
//  Copyright © 2017年 huangbq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

