//
//  TestTableViewController.m
//  TestGroup
//
//  Created by 丁丁 on 15/12/25.
//  Copyright © 2015年 huangyanan. All rights reserved.
//

#import "TestTableViewController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
@interface TestTableViewController ()

@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSMutableArray *isSelected;

@end

@implementation TestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

- (void)loadData {
    if (!self.dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    if (!self.isSelected) {
       self.isSelected = [NSMutableArray array];
    }
    
    self.dataArray = [NSArray arrayWithObjects:@[@"a",@"b",@"c",@"d"],@[@"d",@"e",@"f"],@[@"h",@"i",@"j",@"m",@"n"],nil].mutableCopy;
    //用0代表收起，1代表展开，默认都是收起的
    for (int i = 0; i < self.dataArray.count; i++) {
        [self.isSelected addObject:@0];
    }
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *array = self.dataArray[section];
    if ([self.isSelected[section] boolValue]) {
        return array.count;
    }
    else {
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIButton *headerSection = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    headerSection.backgroundColor = [UIColor clearColor];
    
    NSString *imgName = [self.isSelected[section] boolValue]?@"icon_drop_up":@"icon_drop_down";
    UIImage *img = [UIImage imageNamed:imgName];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    imgView.frame = CGRectMake(kScreenWidth-img.size.width-20, (44-img.size.height)/2.0, img.size.width, img.size.height);
    [headerSection addSubview:imgView];
    
    //分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44-0.5, kScreenWidth, 0.5)];
    lineView.backgroundColor = [UIColor grayColor];
    [headerSection addSubview:lineView];
    
    headerSection.tag = 666+section;
    
    //标题
    [headerSection setTitle:[NSString stringWithFormat:@"第%@组",@(section)] forState:UIControlStateNormal];
    headerSection.font = [UIFont systemFontOfSize:16];
    [headerSection setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [headerSection addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    return headerSection;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)buttonAction:(UIButton *)button {
    NSInteger section = button.tag - 666;
    self.isSelected[section] = [self.isSelected[section] isEqual:@0]?@1:@0;
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:section];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
