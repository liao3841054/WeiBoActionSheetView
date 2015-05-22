//
//  BTActionSheetView.h
//  BanTang
//
//  Created by liaoyp on 15/5/21.
//  Copyright (c) 2015年 JiuZhouYunDong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BTActionSheetView;
typedef void (^BTActionSheetDidSelectViewBlock)(BTActionSheetView *btActionView, UITableViewCell *textCell);

@interface BTActionSheetView : UIView<UITableViewDataSource , UITableViewDelegate>
{
    @private
    UITableView *_tableView;
    
    UIView      *_backView;
    UIView      *_showView;
    BOOL        _isShow;

}
- (void)show;
- (void)hide;
/**
 *  数据源
 */
@property (nonatomic, strong) NSArray *dataSource;

/**
 *  actionSheet 点击回调
 */
@property (nonatomic, copy)BTActionSheetDidSelectViewBlock selectRowBlock;

@end
