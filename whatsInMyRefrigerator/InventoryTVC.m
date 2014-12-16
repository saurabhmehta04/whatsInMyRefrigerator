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
    self.inventoryarr = [[NSMutableArray alloc]init];
    self.username = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    Middlelayer *ml = [[Middlelayer alloc]init];
    NSString *str = [@"http://localhost/inventory.php?name=" stringByAppendingString:self.username];
    NSArray *dicta = [ml downloadItems:str];
    for (id di in dicta){
        NSDictionary *dict = di;
        NSString *name = dict[@"fridgename"];
        [self.inventoryarr addObject:name];
    }
    //NSLog(@"Arr: %@",self.inventoryarr);
    
    
    
    
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
        NSLog(@"buttonIndex: %d",buttonIndex);
        fridge = [alertView textFieldAtIndex:0].text;
        NSLog(@"buttonIndex: %@",[alertView textFieldAtIndex:0].text);
        [self.inventoryarr addObject:fridge];
        
        Middlelayer *ml = [[Middlelayer alloc]init];
        NSString *str = [@"http://localhost/inventory.php?name=" stringByAppendingString:self.username];
        str = [str stringByAppendingString:@"&fridgename="];
        str = [str stringByAppendingString:fridge];
        NSArray *dicta = [ml downloadItems:str];
        for (id di in dicta){
            NSDictionary *dict = di;
            NSString *name = dict[@"fridgename"];
            [self.inventoryarr addObject:name];
            
        }
        [self.tableView reloadData];


    }
    else{
        NSLog(@"buttonIndex2: %d",buttonIndex);
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    InventoryItemTVC *itemvc = [[InventoryItemTVC alloc] initWithStyle:UITableViewStyleGrouped];
    itemvc.title = (NSString *)[self.inventoryarr objectAtIndex:indexPath.row];
     //[self.navigationController  pushViewController:itemvc animated:YES];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:(NSString *)[self.inventoryarr objectAtIndex:indexPath.row] forKey:@"fridge"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
