//
//  CLAlertController.h
//  hybookV2
//
//  Created by 長谷川瞬哉 on 2016/03/14.
//  Copyright © 2016年 INFOCITY. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CLALERTVIEW_WIDTH 278

//typedef enum {
//	Default = 0,
//	Cancel,
//	Destructive
//} CLActionStyle;

@protocol ClAlertControllerDelegate;

@interface CLAlertController : UIViewController

@property(assign, nonatomic) id<ClAlertControllerDelegate> delegate;

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id<ClAlertControllerDelegate>)delegate parent:(UIViewController*)parent;
- (void)addView:(UIView*)view;
- (void)addActionWithTitle:(NSString *)title;

- (void)show;

@end

@protocol ClAlertControllerDelegate <NSObject>

- (void)clAlertController:(CLAlertController*)clAlertController clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

