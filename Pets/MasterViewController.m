//
//  MasterViewController.m
//  Pets
//
//  Created by Trevor Doodes on 14/04/2016.
//  Copyright © 2016 Trevor Doodes. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "PetManager.h"
#import "Pet.h"
#import "NetworkManager.h"
#import "MBProgressHUD.h"

@interface MasterViewController ()

@property PetManager *petManager;
@property NSArray *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    //Custom setup
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NetworkManager *nw = [[NetworkManager alloc] init];
    self.petManager = [[PetManager alloc] initWithNetworkManager:nw];
    
    __weak typeof (self) weakSelf = self;
    [self.petManager getPetsWithSuccessBlock:^(NSArray *petsArray) {
        weakSelf.objects = petsArray;
        [weakSelf.tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failureBlock:^(NSString *message) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                       message:@"No data available"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    }];

}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Pet *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Pet *pet = self.objects[indexPath.row];
    cell.textLabel.text = pet.name;
    cell.detailTextLabel.text = pet.stringForPetType;
    return cell;
}


@end
