//
//  EGOTableBoard.m
//  SmartBus
//
//  Created by launching on 13-5-7.
//  Copyright (c) 2013年 Werner IT Consultancy. All rights reserved.
//

#import "EGOTableViewController.h"

@interface EGOTableViewController ()
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    EGOLoadMoreTableFooterView *_loadMoreFooterView;
    BOOL _refreshing;
    BOOL _loading;
}

@end

@implementation EGOTableViewController

@synthesize egoTableView = _egoTableView;
@synthesize enableRefreshHeader, enableLoadMoreFooter;
@synthesize isLoadingOver = _isLoadingOver;


- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IS_IOS7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    _egoTableView = [[UITableView alloc] initWithFrame:self.container.bounds style:UITableViewStylePlain];
    _egoTableView.backgroundColor = [UIColor clearColor];
    _egoTableView.dataSource = self;
    _egoTableView.delegate = self;
    //_egoTableView.backgroundView.hidden = YES;
    _egoTableView.tableFooterView = [[UIView alloc] init];
    _egoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _egoTableView.frame = self.container.bounds;
    [self.container addSubview:_egoTableView];    
}

#pragma mark - public methods

- (void)setEnableRefreshHeader:(BOOL)enable
{
    enableRefreshHeader = enable;
    
    if (!_refreshHeaderView) {
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.f, 0.f - _egoTableView.bounds.size.height, _egoTableView.frame.size.width, _egoTableView.frame.size.height)];
        _refreshHeaderView.delegate = self;
    }
    [_egoTableView addSubview:_refreshHeaderView];
    [_refreshHeaderView refreshLastUpdatedDate];
    _refreshHeaderView.hidden = !enable;
}

- (void)setEnableLoadMoreFooter:(BOOL)enable
{
    enableLoadMoreFooter = enable;
    
    if (!_loadMoreFooterView) {
        _loadMoreFooterView = [[EGOLoadMoreTableFooterView alloc] initWithFrame:CGRectMake(0.f, _egoTableView.frame.size.height, _egoTableView.bounds.size.width, _egoTableView.bounds.size.height)];
        _loadMoreFooterView.delegate = self;
    }
    [_egoTableView addSubview:_loadMoreFooterView];
    [_loadMoreFooterView setLoadOver:YES];
}

- (void)egoAllRequest {
//    self.isLoadingOver = NO;
    [_egoTableView setContentOffset:CGPointMake(0.f, -70.f-Y_OFFSET) animated:YES];
}

- (void)reloadDataSucceed:(BOOL)succeed
{
    [self performSelector:@selector(doneRefreshingTableViewData) withObject:nil afterDelay:0];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0];
    
    if ( succeed ) {
        [_egoTableView reloadData];
    }
    
    if ( enableLoadMoreFooter )
    {
        CGFloat y = MAX(_egoTableView.frame.size.height, _egoTableView.contentSize.height);
        CGRect rc = _loadMoreFooterView.frame;
        rc.origin.y = y;
        [_loadMoreFooterView setFrame:rc];
    }
    
    [_loadMoreFooterView setLoadOver:(_egoTableView.contentSize.height < _egoTableView.frame.size.height)];
}



- (void)setIsLoadingOver:(BOOL)over
{
    _isLoadingOver = over;
    if ( enableLoadMoreFooter )
    {
        [_loadMoreFooterView setLoadOver:over];
    }
}




#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    return cell;
}


#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)refreshTableViewDataSource {
    [self setIsLoadingOver:NO];
	_refreshing = YES;
}

- (void)doneRefreshingTableViewData {
	_refreshing = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_egoTableView];
}

- (void)loadTableViewDataSource {
    _loading = YES;
}

- (void)doneLoadingTableViewData {
    _loading = NO;
    [_loadMoreFooterView egoLoadMoreScrollViewDataSourceDidFinishedLoading:_egoTableView];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    [_loadMoreFooterView egoLoadMoreScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    [_loadMoreFooterView egoLoadMoreScrollViewDidEndDragging:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [_refreshHeaderView egoRefreshScrollViewDidEndScrollAnimation:scrollView];
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view {
	[self refreshTableViewDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view {
	return _refreshing; // should return if data source model is reloading
}

- (NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view{
	return [NSDate date]; // should return date data source was last changed
}

- (BOOL)enableEGORefreshTableHeaderView {
    return enableRefreshHeader;
}


#pragma mark - 
#pragma mark EGOLoadMoreTableFooterDelegate Methods

- (void)egoLoadMoreTableFooterDidTriggerLoad:(EGOLoadMoreTableFooterView *)view {
	[self loadTableViewDataSource];
}

- (BOOL)egoLoadMoreTableFooterDataSourceIsLoading:(EGOLoadMoreTableFooterView *)view {
	return _loading;
}

- (BOOL)enableEGOLoadMoreTableFooterView {
    return enableLoadMoreFooter;
}


#pragma mark -
#pragma mark Memory Management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//- (void)dealloc {
//	[_refreshHeaderView release], _refreshHeaderView = nil;
//    [_loadMoreFooterView release], _loadMoreFooterView = nil;
//    [super dealloc];
//}


@end
