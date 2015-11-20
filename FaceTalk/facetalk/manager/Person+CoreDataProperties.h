//
//  Person+CoreDataProperties.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/11/5.
//  Copyright © 2015年 wen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *birthday;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *personid;
@property (nullable, nonatomic, retain) NSNumber *sex;
@property (nullable, nonatomic, retain) NSDate *chattime;
@property (nullable, nonatomic, retain) NSOrderedSet<Report *> *report;

@end

@interface Person (CoreDataGeneratedAccessors)

- (void)insertObject:(Report *)value inReportAtIndex:(NSUInteger)idx;
- (void)removeObjectFromReportAtIndex:(NSUInteger)idx;
- (void)insertReport:(NSArray<Report *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeReportAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInReportAtIndex:(NSUInteger)idx withObject:(Report *)value;
- (void)replaceReportAtIndexes:(NSIndexSet *)indexes withReport:(NSArray<Report *> *)values;
- (void)addReportObject:(Report *)value;
- (void)removeReportObject:(Report *)value;
- (void)addReport:(NSOrderedSet<Report *> *)values;
- (void)removeReport:(NSOrderedSet<Report *> *)values;

@end

NS_ASSUME_NONNULL_END
