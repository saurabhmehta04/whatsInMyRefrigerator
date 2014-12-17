//
//  FavouiteTVC.m
//  whatsInMyRefrigerator
//
//  Created by Student on 12/14/14.
//  Copyright (c) 2014 -=fAlC0n=-. All rights reserved.
//

#import "FavouiteTVC.h"
#import "Middlelayer.h"
#import "productVC.h"

@interface FavouiteTVC ()

@end

@implementation FavouiteTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"In favourites view controller");
    
    self.favArry = [[NSMutableArray alloc]init];
    //NSString *usrn = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    Middlelayer *ml = [[Middlelayer alloc]init];
    NSString *str = [@"http://localhost:8888/favourites.php?arg1=" stringByAppendingString:[[NSUserDefaults standardUserDefaults] stringForKey:@"username"]];
    NSArray *dicta = [ml downloadItems:str];
    //NSLog(@"Dat: %@",dicta);
    for (id di in dicta){
        NSDictionary *dict = di;
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        NSString *name = dict[@"itemname"];
        [arr addObject:name];
        NSString *cgy = dict[@"category"];
        [arr addObject:cgy];
        [self.favArry addObject:arr];
    }
    //NSLog(@"%@Data: %@",[[NSUserDefaults standardUserDefaults] stringForKey:@"username"],self.favArry);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSLog(@"rows %lu", (unsigned long)[self.favArry count]);
    return [self.favArry count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"favitem" forIndexPath:indexPath];
    
    static NSString *CellIdentifier = @"favitem";
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSLog(@"fav: %@",self.favArry);
    // Configure the cell...
    
    cell.textLabel.text = [[self.favArry objectAtIndex:indexPath.row] objectAtIndex:0];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    productVC *view = [self.parentViewController.storyboard instantiateViewControllerWithIdentifier:@"product"];
    view.productTitleFromCameraScanner = [[self.favArry objectAtIndex:indexPath.row] objectAtIndex:0];
    view.qtytypeFromInvent = [[self.favArry objectAtIndex:indexPath.row] objectAtIndex:1];
    [view.favval setEnabled:NO];
    [self.navigationController  pushViewController:view animated:YES];
    
}
- (void) viewWillAppear:(BOOL)animated
{
    
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



//Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSUserDefaults *nsudefault = [NSUserDefaults standardUserDefaults];
        [self.favArry removeObjectAtIndex:indexPath.row];
        //setting the array list of favourites after deleting the object and also the table view
        [nsudefault setObject:self.favArry forKey: @"favorites"];
        [self.tableView reloadData];
        [nsudefault synchronize];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSUserDefaults *nsudefault = [NSUserDefaults standardUserDefaults];
    NSString *itemname = [self.favArry objectAtIndex:toIndexPath.row];
    [self.favArry removeObject:itemname];
    
    //setting the array list of favourites after rearranging the object and also the table view
    [self.favArry insertObject:itemname atIndex:fromIndexPath.row];
    [self.tableView reloadData];
    [nsudefault synchronize];
}

@end
