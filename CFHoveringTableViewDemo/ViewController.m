//
//  ViewController.m
//  CFHoveringTableViewDemo
//
//  Created by 于传峰 on 16/9/10.
//  Copyright © 2016年 于传峰. All rights reserved.
//

#import "ViewController.h"
#import "CFHoveringTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"rootCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"-%zd-", indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CFHoveringTableViewController* hoveringVC = [[CFHoveringTableViewController alloc] init];
    [self.navigationController pushViewController:hoveringVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
