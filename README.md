# CLAlertController

UIAlertControllerをカスタムできるようにしました

# Usage

    cl2 = [[CLAlertController alloc]initWithTitle:@"タイトル" message:@"内容" delegate:self parent:self];
    // ボタンの設置
    // 追加した順に左詰め
    [cl2 addActionWithTitle:@"OK"];
		
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 300)];
    label.text = @"こんなこともできる";
    label.backgroundColor = [UIColor blueColor];
    label.textAlignment = NSTextAlignmentCenter;
    [cl2 addView:label];
    [cl2 show];

    - (void)clAlertController:(CLAlertController *)clAlertController clickedButtonAtIndex:(NSInteger)buttonIndex
    {
      // ここでなにかする
    }
    
