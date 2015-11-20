//
//  Report+CoreDataProperties.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/11/5.
//  Copyright © 2015年 wen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Report.h"

NS_ASSUME_NONNULL_BEGIN

@interface Report (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *imgurl;
@property (nullable, nonatomic, retain) NSNumber *isPush;
@property (nullable, nonatomic, retain) Person *inPerson;

@end

NS_ASSUME_NONNULL_END
