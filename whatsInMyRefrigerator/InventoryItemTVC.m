//
//  InventoryItemTVC.m
//  whatsInMyRefrigerator
//
//  Created by Student on 12/6/14.
//  Copyright (c) 2014 -=fAlC0n=-. All rights reserved.
//

#import "InventoryItemTVC.h"
#import "cameraScanner.h"
#import "productVC.h"


@interface InventoryItemTVC ()

@end

@implementation InventoryItemTVC

- (void)viewDidLoad {
    [super viewDidLoad];
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
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Items";
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    cell.textLabel.text= @"HIIII";
    return cell;
}

-(IBAction)AddingItem:(id)sender{
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"Add Product"
                                 message:@"Choose how to add product"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* scan = [UIAlertAction
                         actionWithTitle:@"Scan"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             cameraScanner *view = [[cameraScanner alloc] init];
                             //                             [self presentViewController:viewController animated:YES completion:nil];
                             //[self performSegueWithIdentifier:@"camera" sender:self];
                             [self.navigationController pushViewController:view animated:YES];
                             
                             NSLog(@"In scan UIAlertAction");
                             
                             
                             
                             
                             
                         }];
    
    UIAlertAction* favourites = [UIAlertAction
                         actionWithTitle:@"Favourites"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             //Do some thing here
                             [view dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    
    UIAlertAction* add_manually = [UIAlertAction
                         actionWithTitle:@"Add Manually"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             //productVC *prod = [[productVC alloc]init];
                             productVC *view = [self.storyboard instantiateViewControllerWithIdentifier:@"product"];
                             [self.navigationController pushViewController:view animated:YES];
                             //[self performSegueWithIdentifier:@"product" sender:self];
                             //[self.navigationController performSegueWithIdentifier:@"product" sender:sender];
                             //[self.navigationController showViewController:prod sender:sender];
                             
                             //[view dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    
    
    
    [view addAction:scan];
    [view addAction:favourites];
    [view addAction:add_manually];
    [view addAction:cancel];
    [self presentViewController:view animated:YES completion:nil];
    NSLog(@"Item adding");
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    NSLog(@"ACT NAmweqwsas");
    UIAlertAction *act = (UIAlertAction *)sender;
    NSLog(@"ACT Name:%@",act.title);
    return YES;
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
-(void) viewWillAppear:(BOOL)animated{
    NSLog(@"Will");
}
*/
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"DATA1 Segue");
    if([segue.identifier isEqualToString:@"camera"]){
        NSLog(@"Scan");
    }else if ([segue.identifier isEqualToString:@"product"]){
        productVC *view = segue.destinationViewController;  
    }
}
/*
-(void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    NSLog(@"DATA2 Segue");
    if([identifier isEqualToString:@"camera"]){
        NSLog(@"Scan");
        cameraScanner *view = [[cameraScanner alloc]init];
    }else if ([identifier isEqualToString:@"product"]){
        NSLog(@"Product");
        productVC *view = [[productVC alloc]init];
    }
    
}

*/

@end
