# CLAlertController

UIAlertControllerをカスタムできるようにしました

# Usage

    CLAlertController* cl = [[CLAlertController alloc]initWithTitle:@"タイトル" message:@"内容" delegate:self parent:self];
    // ボタンの設置
    // 追加した順に左詰め
    [cl addActionWithTitle:@"OK"];
		
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 300)];
    label.text = @"こんなこともできる";
    label.backgroundColor = [UIColor blueColor];
    label.textAlignment = NSTextAlignmentCenter;
    [cl addView:label];
    [cl show];

    - (void)clAlertController:(CLAlertController *)clAlertController clickedButtonAtIndex:(NSInteger)buttonIndex
    {
      // ここでなにかする
    }
    
