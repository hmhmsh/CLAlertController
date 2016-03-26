//
//  CLAlertController.m
//  hybookV2
//
//  Created by 長谷川瞬哉 on 2016/03/14.
//  Copyright © 2016年 INFOCITY. All rights reserved.
//

#import "CLAlertController.h"

#define LINECOLOR @"#E7E7E7"

#define SIDEMARGIN 20
#define TOPMARGIN 20
#define FONTSIZE 13
#define LINESIZE 1
#define LABELSIZE 20
#define BUTTONSIZE 45

@protocol ClAlertViewDelegate;

@interface CLAlertView : UIView
{
	CGFloat width;
	NSMutableArray* buttons;

	UILabel* _titleLabel;
	UILabel* _messageLabel;
	UIView* _customView;
	UIView* _horizonalLine;

//	UIVisualEffectView* effectView;
	
	id<ClAlertViewDelegate> _delegate;
}

- (id)initWithFrame:(CGRect)frame title:(NSString *)title message:(NSString *)message delegate:(id<ClAlertViewDelegate>)delegate;
- (void)addView:(UIView*)view;
- (void)addActionWithTitle:(NSString *)title;

@end

@protocol ClAlertViewDelegate <NSObject>

- (void)clAlertView:(CLAlertView*)clAlertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@implementation CLAlertView

/* No ARC 用
- (void)dealloc
{
	[buttons removeAllObjects];
	[buttons release];
	buttons = nil;
	
	[_titleLabel release];
	_titleLabel = nil;
	
	[_messageLabel release];
	_messageLabel = nil;
	
	[_customView release];
	_customView = nil;
	
	[_horizonalLine release];
	_horizonalLine = nil;
	
//	[effectView release];
//	effectView = nil;
	
	[super dealloc];
}
*/

- (id)initWithFrame:(CGRect)frame title:(NSString *)title message:(NSString *)message delegate:(id<ClAlertViewDelegate>)delegate
{
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor whiteColor];
		
//		UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
//		effectView = [[[UIVisualEffectView alloc] initWithEffect:blurEffect] autorelease];
//		effectView.backgroundColor = [UIColor clearColor];
//		effectView.clipsToBounds = YES;
//		
//		effectView.frame = self.bounds;
//		effectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//		[self addSubview:effectView];
		
		_delegate = delegate;
		
		width = self.frame.size.width;
		CGFloat height = 0;
		
		_titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SIDEMARGIN, TOPMARGIN, width - SIDEMARGIN * 2, LABELSIZE)];
		_titleLabel.text = title;
		_titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
		_titleLabel.textAlignment = NSTextAlignmentCenter;
		_titleLabel.numberOfLines = 1;
		[self addSubview:_titleLabel];
		
		CGSize rect = [_titleLabel sizeThatFits:_titleLabel.frame.size];
		_titleLabel.frame = CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y, _titleLabel.frame.size.width, rect.height);
		
		height = CGRectGetMaxY(_titleLabel.frame);
		
		_messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(SIDEMARGIN, height + 5, width - SIDEMARGIN * 2, LABELSIZE)];
		_messageLabel.text = message;
		_messageLabel.textAlignment = NSTextAlignmentCenter;
		_messageLabel.font = [UIFont systemFontOfSize:FONTSIZE];
		_messageLabel.numberOfLines = 3;
		[self addSubview:_messageLabel];

		rect = [_messageLabel sizeThatFits:_messageLabel.frame.size];
		_messageLabel.frame = CGRectMake(_messageLabel.frame.origin.x, _messageLabel.frame.origin.y, _messageLabel.frame.size.width, rect.height);

		height = CGRectGetMaxY(_messageLabel.frame);
		
		_horizonalLine = [[UIView alloc]initWithFrame:CGRectMake(0, height + TOPMARGIN, width, LINESIZE)];
		_horizonalLine.backgroundColor = [self hexcolorToUIColor:LINECOLOR];
		[self addSubview:_horizonalLine];
		
		height = CGRectGetMaxY(_horizonalLine.frame);

		self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
//		effectView.frame = self.bounds;
	}
	return self;
}

- (void)addView:(UIView*)view
{
	CGFloat viewWidth = view.frame.size.width;
	CGFloat height = 0;

	height = _horizonalLine.frame.origin.y;
	
	if (viewWidth > width) {
		viewWidth = width;
	}
	view.frame = CGRectMake((width - view.frame.size.width) / 2, height, viewWidth, view.frame.size.height);
	[self addSubview:view];
	
	height = CGRectGetMaxY(view.frame);
	
	_horizonalLine.frame = CGRectMake(_horizonalLine.frame.origin.x, height + TOPMARGIN, _horizonalLine.frame.size.width, _horizonalLine.frame.size.height);
	
	[self adjustmentButton];
}

- (void)addActionWithTitle:(NSString *)title
{

	if (!buttons) {
		buttons = [[NSMutableArray alloc]init];
	}
	
	UIButton* button = [[UIButton alloc]init];
	[button setTitle:title forState:UIControlStateNormal];
	[button setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
	button.tag = buttons.count;
	[button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:button];
	
	[buttons addObject:button];

	[self adjustmentButton];
	
}

- (void)adjustmentButton
{
	CGFloat height = CGRectGetMaxY(_horizonalLine.frame);
	
	if (buttons.count == 1) {
		
		UIButton* button = buttons[0];
		button.frame = CGRectMake(0, height, width, BUTTONSIZE);
		
		height = CGRectGetMaxY(button.frame);

	} else if (buttons.count == 2) {
		UIButton* button;
		
		for (int index = 0; index < buttons.count; index++) {
			
			if (index > 0) {
				UIView* line = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(button.frame), height, LINESIZE, BUTTONSIZE)];
				line.backgroundColor = [self hexcolorToUIColor:LINECOLOR];
				[self addSubview:line];
			}

			button = buttons[index];
			button.frame = CGRectMake(index * ((width - 1) / 2 + 1), height, (width - 1) / 2, BUTTONSIZE);
			
			if (index == buttons.count - 1) {
				button.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
			} else {
				button.titleLabel.font = [UIFont systemFontOfSize:[UIFont buttonFontSize]];
			}

		}

		height = CGRectGetMaxY(button.frame);
		
	} else if (buttons.count > 2) {

		UIButton* button;
		
		for (int index = 0; index < buttons.count; index++) {
			
			if (index > 0) {
				UIView* line = [[UIView alloc]initWithFrame:CGRectMake(0, height, width, LINESIZE)];
				line.backgroundColor = [self hexcolorToUIColor:LINECOLOR];
				[self addSubview:line];
				
				height = CGRectGetMaxY(line.frame);
			}
			
			button = buttons[index];
			button.frame = CGRectMake(0, height, width, BUTTONSIZE);
			
			if (index == buttons.count - 1) {
				button.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
			} else {
				button.titleLabel.font = [UIFont systemFontOfSize:[UIFont buttonFontSize]];
			}

			height = CGRectGetMaxY(button.frame);
		}

	}
	
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
//	effectView.frame = self.bounds;

}

- (void)selectButton:(id)sender
{
	UIButton* button = (UIButton*)sender;
	if (_delegate && [_delegate respondsToSelector:@selector(clAlertView:clickedButtonAtIndex:)]) {
		[_delegate clAlertView:self clickedButtonAtIndex:button.tag];
	}
}

#pragma mark hexColorToUIColor
- (UIColor*)hexcolorToUIColor:(NSString*)hexColorStr
{
	NSString *colorString = [NSString stringWithFormat:
													 @"0x%@ 0x%@ 0x%@",
													 [hexColorStr substringWithRange:NSMakeRange(1, 2)],
													 [hexColorStr substringWithRange:NSMakeRange(3, 2)],
													 [hexColorStr substringWithRange:NSMakeRange(5, 2)]];
	unsigned red, green, blue;
	NSScanner *scanner = [NSScanner scannerWithString:colorString];
	
	if ([scanner scanHexInt:&red] && [scanner scanHexInt:&green] && [scanner scanHexInt:&blue]) {
		return [UIColor colorWithRed:(CGFloat)red/255.0 green:(CGFloat)green/255.0 blue:(CGFloat)blue/255.0 alpha:255.0/255.0];
	}
	return [UIColor whiteColor];
}

@end

@interface CLAlertController ()<ClAlertViewDelegate>

{
	UIViewController* _parent;
	CLAlertView* _clAlertView;
}
@end

@implementation CLAlertController

/*
- (void)dealloc
{
	
	[_clAlertView release];
	_clAlertView = nil;
	
	_delegate = nil;

	[super dealloc];
}
*/

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id<ClAlertControllerDelegate>)delegate parent:(UIViewController *)parent
{
	self = [super init];
	if (self) {

		_delegate = delegate;

		_clAlertView = [[CLAlertView alloc]initWithFrame:CGRectMake(0, 0, CLALERTVIEW_WIDTH, 0) title:title message:message delegate:self];
		_clAlertView.layer.cornerRadius = 5.0f;
		_clAlertView.clipsToBounds = YES;

		_parent = parent;
	}
	return self;
}

- (void)addView:(UIView*)view
{
	[_clAlertView addView:view];
}

- (void)addActionWithTitle:(NSString *)title
{
	[_clAlertView addActionWithTitle:title];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.view.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f];
	
	[self adjustViewPosition];
	
	[self.view addSubview:_clAlertView];
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


- (void)adjustViewPosition
{
	CGRect screenBounds = [[UIScreen mainScreen] bounds];
	float screenWidth = screenBounds.size.width;
	float screenHeight = screenBounds.size.height;
	
	UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
	if (orientation == UIInterfaceOrientationLandscapeRight || orientation == UIInterfaceOrientationLandscapeLeft) {
		if (screenWidth < screenHeight) {
			self.view.bounds = CGRectMake(0.0f ,0.0f ,screenHeight, screenWidth);
		} else {
			self.view.bounds = CGRectMake(0.0f ,0.0f ,screenWidth, screenHeight);
		}
	} else {
		if (screenHeight < screenWidth) {
			self.view.bounds = CGRectMake(0.0f ,0.0f ,screenHeight, screenWidth);
		} else {
			self.view.bounds = CGRectMake(0.0f ,0.0f ,screenWidth, screenHeight);
		}
	}
	
//	self.view.frame = self.view.bounds;
	
	float const backgroundWidth = self.view.frame.size.width;
	float const backgroundHeight = self.view.frame.size.height;
	
	/*
	 if (backgroundWidth < _reviewView.frame.size.width) {
	 float reviewWidth = backgroundWidth - HOLIZONTAL_PADDING*2;
	 float reviewHeight = reviewWidth + 10.0f;
	 _reviewView.frame.size = CGSizeMake(reviewWidth, reviewHeight);
	 }
	 */
	
	[_clAlertView setCenter:CGPointMake(backgroundWidth/2, backgroundHeight/2)];
}

- (void)show
{
	float osVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
	
	self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	if (osVersion >= 8.0f) {
		self.modalPresentationStyle = UIModalPresentationOverFullScreen;
		
		[_parent presentViewController:self animated:YES completion:nil];
	}
	else {
		UIModalPresentationStyle pStyle = _parent.modalPresentationStyle;
		
		_parent.modalPresentationStyle = UIModalPresentationCurrentContext;
		[_parent presentViewController:self animated:YES completion:nil];
		
		_parent.modalPresentationStyle = pStyle;
	}

}

- (void)clAlertView:(CLAlertView *)clAlertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	[_parent dismissViewControllerAnimated:YES completion:nil];
	
	if (_delegate && [_delegate respondsToSelector:@selector(clAlertController:clickedButtonAtIndex:)]) {
		[_delegate clAlertController:self clickedButtonAtIndex:buttonIndex];
	}
}

@end
