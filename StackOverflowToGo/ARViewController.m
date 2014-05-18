//
//  ARViewController.m
//  StackOverflowToGo
//
//  Created by Anton Rivera on 5/17/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "ARViewController.h"
#import "ARSearchResult.h"
#import "ARWebViewController.h"

@interface ARViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *searchResultsArray;

@end

@implementation ARViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _searchBar.delegate = self;
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    _searchResultsArray = [NSMutableArray new];
    
    [self getSearchResultsForQuery:@"iOS" withCompletion:^(NSMutableArray *array) {
        _searchResultsArray = array;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [_tableView reloadData];
        }];
    }];
}

- (void)getSearchResultsForQuery:(NSString *)query withCompletion:(void(^)(NSMutableArray *array))completionBlock
{
    query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSOperationQueue *downloadQueue = [NSOperationQueue new];
    [downloadQueue addOperationWithBlock:^{
        NSString *searchURLString = [NSString stringWithFormat:@"http://api.stackexchange.com/2.2/search?order=desc&sort=activity&intitle=%@&site=stackoverflow", query];
        NSURL *searchURL = [NSURL URLWithString:searchURLString];
        NSData *searchData = [NSData dataWithContentsOfURL:searchURL];
        NSDictionary *searchDict = [NSJSONSerialization JSONObjectWithData:searchData
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:nil];
        NSMutableArray *resultArray = [searchDict objectForKey:@"items"];
        NSMutableArray *tempArray = [NSMutableArray new];
        if ([resultArray isKindOfClass:[NSMutableArray class]]) {
            [resultArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                ARSearchResult *searchResult = [[ARSearchResult alloc] initWithTitle:obj];
                [tempArray addObject:searchResult];
            }];
            completionBlock(tempArray);
        }
    }];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    [self getSearchResultsForQuery:searchBar.text withCompletion:^(NSMutableArray *array) {
        _searchResultsArray = array;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [_tableView reloadData];
        }];
    }];
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _searchResultsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    ARSearchResult *searchResult = _searchResultsArray[indexPath.row];
    cell.textLabel.text = searchResult.title;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [tableView reloadData];
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showWebView"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ARSearchResult *searchResult = [_searchResultsArray objectAtIndex:indexPath.row];
        ARWebViewController *wvc = (ARWebViewController *)segue.destinationViewController;
        
        wvc.link = searchResult.link;
    }
}

@end
