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
    self.inventoryItemarr = [[NSMutableArray alloc]init];
    self.username = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    NSLog(@"username: %@",self.username);
    
    Middlelayer *ml = [[Middlelayer alloc]init];
    NSString *str = @"http://wtf.lokesh-cherukuri.com/inventoryitems.php?arg1=";
    str = [str stringByAppendingString:self.username];
    str = [str stringByAppendingString:@"&arg2="];
    str = [str stringByAppendingString:[[NSUserDefaults standardUserDefaults] stringForKey:@"fridge"]];
    NSArray *dicta = [ml downloadItems:str];
    NSLog(@"Name: %d",[dicta count]);
    NSDictionary *dict = (NSDictionary *)dicta[0];
    for (id di in dicta){
        NSDictionary *dict = di;
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        NSString *name = dict[@"itemname"];
        //NSLog(@"Name: %@",name);
        [arr addObject:name];
        NSString *qty = dict[@"qty"];
        //NSLog(@"Name: %@",qty);
        [arr addObject:qty];
        NSString *cgy = dict[@"category"];
        //NSLog(@"Name: %@",cgy);
        [arr addObject:cgy];
        NSString *edate = dict[@"edate"];
        //NSLog(@"Name: %@",edate);
        [arr addObject:edate];
        NSString *fav = dict[@"fav"];
        [arr addObject:fav];
        //NSLog(@"Name: %@",fav);
        [self.inventoryItemarr addObject:arr];
    }
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
    return [self.inventoryItemarr count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Items";
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    cell.textLabel.text = [[self.inventoryItemarr objectAtIndex:indexPath.row] objectAtIndex:0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;

}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    productVC *view = [self.parentViewController.storyboard instantiateViewControllerWithIdentifier:@"product"];
    view.productTitleFromCameraScanner = [[self.inventoryItemarr objectAtIndex:indexPath.row] objectAtIndex:0];
    //view.productTitle.userInteractionEnabled = NO;
    //[view.productTitle endEditing:YES];
    //[view.productTitle setUserInteractionEnabled:NO];
    //[view.productTitle setEnabled:NO];
    view.qtyFromInvent = [[self.inventoryItemarr objectAtIndex:indexPath.row] objectAtIndex:1];
    view.qtytypeFromInvent = [[self.inventoryItemarr objectAtIndex:indexPath.row] objectAtIndex:2];
    view.edateFromInvent = [[self.inventoryItemarr objectAtIndex:indexPath.row] objectAtIndex:3];
    view.favfromInvent = [[self.inventoryItemarr objectAtIndex:indexPath.row] objectAtIndex:4];
    //NSLog(@"ASD%@",view.favfromInvent);
    //view.favfromInvent = [[[self.inventoryItemarr objectAtIndex:indexPath.row] objectAtIndex:4] alue];
    [self.navigationController  pushViewController:view animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void) viewWillAppear:(BOOL)animated
{
    [self viewDidLoad];
    [self.tableView reloadData];
}

//Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        //NSUserDefaults *nsudefault = [NSUserDefaults standardUserDefaults];
        
        [self.inventoryItemarr removeObjectAtIndex:indexPath.row];
        
        
        Middlelayer *ml = [[Middlelayer alloc]init];
        NSString *str = [@"http://wtf.lokesh-cherukuri.com/inventoryitemsdelete.php?name=" stringByAppendingString:self.username];
        str = [str stringByAppendingString:@"&fridgename="];
        str = [str stringByAppendingString:[[NSUserDefaults standardUserDefaults] stringForKey:@"fridge"]];
        str = [str stringByAppendingString:@"&item="];
        str = [str stringByAppendingString:[[self.inventoryItemarr objectAtIndex:indexPath.row] objectAtIndex:0]];
//        NSArray *dicta = [ml downloadItems:str];
        
        [self.tableView reloadData];
    }
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
                             view.hidesBottomBarWhenPushed = YES;
                             [self.navigationController setNavigationBarHidden:NO animated:YES];
                             [self.navigationController pushViewController:view animated:YES];
                             //NSLog(@"In scan UIAlertAction");
                             
                         }];
    
    UIAlertAction* favourites = [UIAlertAction
                         actionWithTitle:@"Favourites"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             FavouiteTVC *favController = [[FavouiteTVC alloc]init];
                             [self.navigationController pushViewController:favController animated:YES];
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
    //NSLog(@"Item adding");
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    //NSLog(@"ACT NAmweqwsas");
    UIAlertAction *act = (UIAlertAction *)sender;
    //NSLog(@"ACT Name:%@",act.title);
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
    //NSLog(@"DATA1 Segue");
    if([segue.identifier isEqualToString:@"camera"]){
       // NSLog(@"Scan");
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
