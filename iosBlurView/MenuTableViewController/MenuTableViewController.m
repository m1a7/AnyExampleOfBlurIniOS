//
//  MenuTableViewController.m
//  iosBlurView
//
//  Created by Uber on 16/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import "MenuTableViewController.h"

// ViewControllers
#import "BlurViewController1.h"
#import "BlurViewController2.h"
#import "BlurViewController3.h"


#define BlurViewController1 @"BlurViewController1"
#define BlurViewController2 @"BlurViewController2"
#define BlurViewController3 @"BlurViewController3"
#define BlurViewController4 @"BlurViewController4"


@interface MenuTableViewController ()
@property (nonatomic, strong) NSArray* data;
@end

@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.data = @[BlurViewController1,BlurViewController2,BlurViewController3,BlurViewController4];
  
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView  cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *identifier =  self.data[indexPath.row];
    id vc = [[NSClassFromString(identifier) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
