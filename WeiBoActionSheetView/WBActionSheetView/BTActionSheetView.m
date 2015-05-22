//
//  BTActionSheetView.m
//  BanTang
//
//  Created by liaoyp on 15/5/21.
//  Copyright (c) 2015年 JiuZhouYunDong. All rights reserved.
//

#import "BTActionSheetView.h"

#define RGB(x,y,z) [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:1.0]
#define FONT(F) [UIFont fontWithName:nil size:F]
#define DefaultTextColor RGB(68, 68, 68)
#define KKROWCELLHEIGHT 50

NSString * const BTActionSheetViewTableCellKey = @"SettingCell";

@implementation BTActionSheetView

- (instancetype)init
{
    self = [super init];
    if (self) {
        CGRect frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        self.frame =frame;
        [self initContentView];

    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    CGRect appFrame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    self = [super initWithFrame:appFrame];
    if (self) {
        
        [self initContentView];

    }
    return self;
}

- (void)initContentView
{
    _backView = [[UIView alloc] initWithFrame:self.frame];
    _backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [self addSubview:_backView];
    
    _tableView = [[UITableView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = RGB(230, 230, 230);
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.bounces = NO;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:BTActionSheetViewTableCellKey];
    [self addSubview:_tableView];
    _showView = _tableView;
    
    _showView.frame = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), CGRectGetWidth(_showView.frame));
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:_backView];
    if (!CGRectContainsPoint([_showView frame], pt))
    {
        [self hide];
    }
}

- (void)setDataSource:(NSArray *)dataSource
{
    _dataSource = dataSource;
    float height = (dataSource.count +1 ) *KKROWCELLHEIGHT + 5;
    
    /**
     *  删除之前的约束条件
     */
    [[self constraints] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self removeConstraint:obj];
    }];
    
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_tableView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:height]];
    
    [_tableView reloadData];

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

#pragma mark -
#pragma mark TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 1;
    }
    return [_dataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BTActionSheetViewTableCellKey forIndexPath:indexPath];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = FONT(14);
    cell.textLabel.textColor = DefaultTextColor;
    
    /* 设置cell点击颜色值 */
    UIView *selectView = [UIView new];
    selectView.backgroundColor =RGB(242, 242, 242);
    cell.selectedBackgroundView = selectView;
    
    if (indexPath.section == 0) {
        cell.textLabel.text = _dataSource[indexPath.row];
    }else if (indexPath.section == 1)
    {
        cell.textLabel.text = @"取消";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 5.0;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view  =[UIView new];
    view.backgroundColor = RGB(238, 238, 238);
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_selectRowBlock) {
        _selectRowBlock(self, [tableView cellForRowAtIndexPath:indexPath]);
    }
}

#pragma mark - public
- (void)show
{
    if(_isShow)
    {
        return;
    }
    _isShow = YES;
    _backView.alpha = 1.0;
    
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
    [UIView animateWithDuration:0.35
                     animations:^{
                         
                        // _showView.transform = CGAffineTransformIdentity;
                         
                         _showView.frame = CGRectMake(0, CGRectGetHeight(self.frame) - CGRectGetHeight(_showView.frame), CGRectGetWidth(self.frame), CGRectGetWidth(_showView.frame));

                         
                     }];
}

- (void)hide
{
    _isShow = NO;
    
    [UIView animateWithDuration:0.35
                     animations:^{
                         
                         _backView.alpha = 0.0;
                        float height =  CGRectGetHeight(_showView.frame);
                        
                         _showView.frame = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), CGRectGetWidth(_showView.frame));
                         
                     } completion:^(BOOL finished) {
                         
                         [self removeFromSuperview];
                         
                     }];
}


@end
