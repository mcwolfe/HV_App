//
//  hvAppDelegate.h
//  HVApp
// hej
//  Created by Rickard Fjeldseth on 2012-12-10.
//  Copyright (c) 2012 Högskolan Väst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hvAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
