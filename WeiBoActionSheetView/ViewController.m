//
//  ViewController.m
//  WeiBoActionSheetView
//
//  Created by liaoyp on 15/5/22.
//  Copyright (c) 2015年 BT. All rights reserved.
//

#import "ViewController.h"
#import "BTActionSheetView.h"

@interface ViewController ()
{
    BTActionSheetView *_weiBoSheetView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)commentAction:(id)sender {
    
    [self setUpActionSheetView];
    _weiBoSheetView.dataSource = @[@"评论",@"回复",@"复制"];
    [_weiBoSheetView setSelectRowBlock:^(BTActionSheetView *btActionView, UITableViewCell *textCell){
        
        NSString *rowText = textCell.textLabel.text;
        if ([@"评论" isEqualToString:rowText ]) {
            
        }else if ([@"回复" isEqualToString:rowText ]) {
            
        }else if ([@"复制" isEqualToString:rowText ]) {
            
        }else if ([@"取消" isEqualToString:rowText ]) {
            
        }
        _kTextLabel.text = rowText;
        [btActionView hide];
    }];

    [_weiBoSheetView show];

}
- (IBAction)deleteAction:(id)sender {
    
    [self setUpActionSheetView];
    _weiBoSheetView.dataSource = @[@"删除",@"评论",@"回复",@"复制"];
    [_weiBoSheetView setSelectRowBlock:^(BTActionSheetView *btActionView, UITableViewCell *textCell){
        
        NSString *rowText = textCell.textLabel.text;
        if ([@"评论" isEqualToString:rowText ]) {
            
        }else if ([@"回复" isEqualToString:rowText ]) {
            
        }else if ([@"复制" isEqualToString:rowText ]) {
            
        }else if ([@"取消" isEqualToString:rowText ]) {
            
        }
        _kTextLabel.text = rowText;
        [btActionView hide];
    }];

    [_weiBoSheetView show];

}

- (void)setUpActionSheetView
{
    if (!_weiBoSheetView) {
         _weiBoSheetView = [[BTActionSheetView alloc] init];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
