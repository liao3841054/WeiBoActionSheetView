# WeiBoActionSheetView

仿新浪微博自定义的ActionSheet， 代码炒鸡简单易用.
两行代码即可集成，采用Block进行回调

![enter image description here](http://g.recordit.co/ln0G3iXajR.gif)

```
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
```
