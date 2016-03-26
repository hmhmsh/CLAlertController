//
//  ViewController.m
//  CLAlertController
//
//  Created by 長谷川瞬哉 on 2016/03/26.
//  Copyright © 2016年 長谷川瞬哉. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () 
{
	CLAlertController* cl1;
	CLAlertController* cl2;
}
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	cl1 = [[CLAlertController alloc]initWithTitle:@"1番目" message:@"2番目を表示する？" delegate:self parent:self];
	[cl1 addActionWithTitle:@"NO"];
	[cl1 addActionWithTitle:@"YES"];
	
	UIButton* cl1ShowButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
	cl1ShowButton.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
	[cl1ShowButton setTitle:@"表示" forState:UIControlStateNormal];
	cl1ShowButton.backgroundColor = [UIColor lightGrayColor];
//	[cl1ShowButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
	[cl1ShowButton addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
	
	cl1ShowButton.layer.cornerRadius = 150;
	cl1ShowButton.layer.masksToBounds = YES;
	[self.view addSubview:cl1ShowButton];

}

- (void)tapAction:(UIButton*)button
{
	[cl1 show];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)clAlertController:(CLAlertController *)clAlertController clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (clAlertController == cl1) {
		switch (buttonIndex) {
			case 0:
    		// いいえ
    break;
			case 1:
				// はい
				if (!cl2) {
					cl2 = [[CLAlertController alloc]initWithTitle:@"2番目" message:@"おしまい" delegate:self parent:self];
					[cl2 addActionWithTitle:@"OK"];
					
					UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 300)];
					label.text = @"こんなこともできる";
					label.backgroundColor = [UIColor blueColor];
					label.textAlignment = NSTextAlignmentCenter;
					[cl2 addView:label];
				}
				
				[cl2 show];

    break;
				
			default:
    break;
		}
	} else if (clAlertController == cl2) {
		switch (buttonIndex) {
			case 0:
				// OK
    break;
				
			default:
    break;
		}
	}

}

@end
