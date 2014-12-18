//
//  InventoryTVC.m
//  whatsInMyRefrigerator
//
//  Created by Student on 12/6/14.
//  Copyright (c) 2014 -=fAlC0n=-. All rights reserved.
//

#import "InventoryTVC.h"

@interface InventoryTVC ()

@end

@implementation InventoryTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    self.inventoryarr = [[NSMutableArray alloc]init];
    self.username = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    Middlelayer *ml = [[Middlelayer alloc]init];
    NSString *str = [@"http://wtf.lokesh-cherukuri.com/inventory.php?name=" stringByAppendingString:self.username];
    NSArray *dicta = [ml downloadItems:str];
    for (id di in dicta){
        NSDictionary *dict = di;
        NSString *name = dict[@"fridgename"];
        [self.inventoryarr addObject:name];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.inventoryarr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SampleCell";
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSString *name = [self.inventoryarr objectAtIndex:indexPath.row];
    cell.textLabel.text = name;
    return cell;
}

-(IBAction)Adding:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add a New Fridge"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Ok",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *fridge;
    if (buttonIndex == 1) {
        if (![[alertView textFieldAtIndex:0].text isEqualToString:@""]) {
            fridge = [alertView textFieldAtIndex:0].text;
                    [self.inventoryarr addObject:fridge];
                    Middlelayer *ml = [[Middlelayer alloc]init];
                    NSString *str = [@"http://wtf.lokesh-cherukuri.com/inventory.php?name=" stringByAppendingString:self.username];
                    str = [str stringByAppendingString:@"&fridgename="];
                    str = [str stringByAppendingString:fridge];
                    NSArray *dicta = [ml downloadItems:str];
                    [self.tableView reloadData];
        }else{
            UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Invalid Name" message:@"Please enter a valid Name"  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
           [al show];
        
        }

    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    InventoryItemTVC *itemvc = [[InventoryItemTVC alloc] initWithStyle:UITableViewStyleGrouped];
    itemvc.title = (NSString *)[self.inventoryarr objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:(NSString *)[self.inventoryarr objectAtIndex:indexPath.row] forKey:@"fridge"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



//Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
               
        //NSUserDefaults *nsudefault = [NSUserDefaults standardUserDefaults];
        
       [self.inventoryarr removeObjectAtIndex:indexPath.row];
        
        
//        Middlelayer *ml = [[Middlelayer alloc]init];
//        NSString *str = [@"http://wtf.lokesh-cherukuri.com/inventorydelete.php?name=" stringByAppendingString:self.username];
//        str = [str stringByAppendingString:@"&fridgename="];
//        str = [str stringByAppendingString:[self.inventoryarr objectAtIndex:indexPath.row]];
//        NSArray *dicta = [ml downloadItems:str];

        [self.tableView reloadData];
        
        
        
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    //    else if (editingStyle == UITableViewCellEditingStyleInsert) {
    //        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    //    }
}




@end
