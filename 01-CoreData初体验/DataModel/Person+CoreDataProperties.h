//
//  Person+CoreDataProperties.h
//  01-CoreData初体验
//
//  Created by huangbq on 2017/1/6.
//  Copyright © 2017年 huangbq. All rights reserved.
//

#import "Person+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int32_t age;

@end

NS_ASSUME_NONNULL_END
