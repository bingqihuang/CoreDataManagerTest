//
//  Person+CoreDataProperties.m
//  01-CoreData初体验
//
//  Created by huangbq on 2017/1/6.
//  Copyright © 2017年 huangbq. All rights reserved.
//

#import "Person+CoreDataProperties.h"

@implementation Person (CoreDataProperties)

+ (NSFetchRequest<Person *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Person"];
}

@dynamic name;
@dynamic age;

@end
