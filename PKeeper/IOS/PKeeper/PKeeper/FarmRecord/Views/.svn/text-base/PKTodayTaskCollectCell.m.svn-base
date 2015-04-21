//
//  PKTodayTaskCollectCell.m
//  PKeeper
//
//  Created by mylonly on 15/3/22.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKTodayTaskCollectCell.h"
#import "PKEditBoard.h"

@interface PKTodayTaskCollectCell()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* m_tableView;
}
@end

@implementation PKTodayTaskCollectCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = RGB(240, 240, 240);
        UIView* contanierView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 170)];
        contanierView.layer.cornerRadius = 5.f;
        contanierView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:contanierView];
        
        UIImageView* sepe = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19, 170)];
        sepe.image = [UIImage imageNamed:@"addrecord_biankuang"];
        [contanierView addSubview:sepe];
        
        UILabel* tips = [[UILabel alloc] initWithFrame:CGRectMake(20, 5 , 200, 20)];
        tips.text = @"今日工作内容";
        tips.textColor = RGB(249, 127, 36);
        [contanierView addSubview:tips];
        
        m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 25, 280, 150)];
        m_tableView.dataSource = self;
        m_tableView.delegate = self;
        [contanierView addSubview:m_tableView];
    }
    return self;
}

- (void)setItemDictArray:(NSArray *)itemDictArray
{
    _itemDictArray = itemDictArray;
    [m_tableView reloadData];
}

#pragma mark tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _itemDictArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.f;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* itemCellIdentifier = @"ItemCellIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:itemCellIdentifier];
    }
    NSDictionary* item = _itemDictArray[indexPath.row];
    cell.textLabel.text = [item valueForKey:@"name"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@",[item valueForKey:@"value"],[item valueForKey:@"unit"]];
    return cell;
}

#pragma mark tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* item = _itemDictArray[indexPath.row];
    if ([_delegate respondsToSelector:@selector(itemCellSelected:)])
    {
        [_delegate itemCellSelected:[item valueForKey:@"name"]];
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
