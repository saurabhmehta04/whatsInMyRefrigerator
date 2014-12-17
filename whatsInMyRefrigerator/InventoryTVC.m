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
    NSString *str = [@"http://localhost:8888/inventory.php?name=" stringByAppendingString:self.username];
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
        NSLog(@"buttonIndex: %ld",(long)buttonIndex);
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
        NSLog(@"buttonIndex2: %ld",(long)buttonIndex);
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    InventoryItemTVC *itemvc = [[InventoryItemTVC alloc] initWithStyle:UITableViewStyleGrouped];
    itemvc.title = (NSString *)[self.inventoryarr objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:(NSString *)[self.inventoryarr objectAtIndex:indexPath.row] forKey:@"fridge"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



@end
