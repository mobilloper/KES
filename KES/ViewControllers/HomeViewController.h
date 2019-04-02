//
//  HomeViewController.h
//  KES
//
//  Created by matata on 2/13/18.
//  Copyright © 2018 matata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServices.h"
#import "NewsMoreViewController.h"
#import "NSDate+TimeAgo.h"
#import "iCarousel.h"
#import "AppDelegate.h"

@interface HomeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, WebServicesDelegate, iCarouselDataSource, iCarouselDelegate, UISearchBarDelegate>
{
    NSMutableArray *feedArray, *newsArray, *offersArray, *bookArray;
    NSMutableArray *filterFeedArray, *filterNewsArray, *filterOffersArray, *filterBookArray;
    NSMutableArray *searchFeedArray, *searchNewsArray, *searchOffersArray, *searchBookArray;
    UIRefreshControl *refreshControl;
    NSString *category;
    WebServices *objWebServices;
    NSString *lastMonthNewsApi, *lastMonthBookApi, *lastMonthOffersApi;
    NSString *totalNewsApi, *totalBookApi, *totalOffersApi;
    NSString *newsApi, *booksApi, *offersApi, *countDownApi, *contactApi;
    NSUserDefaults *userInfo;
    NSMutableArray *aryPrice;
    NSDate *startOfMonth, *endOfMonth, *startOfLastMonth, *endOfLastMonth;
    BOOL isSearching;
}

@property (nonatomic) BOOL isLoadTimePrompt;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *categorySeg;
@property (weak, nonatomic) IBOutlet UILabel *noPromptLbl;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UIButton *searchBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *searchBarHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *closeBtnHeight;

@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (nonatomic, strong) UIColor *selectItemColor, *normalItemColor, *selectedTextColor, *normalTextColor;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic) BOOL isClicked;
@property (nonatomic, readwrite) float width;
@property (nonatomic, readwrite) float height;
@property (nonatomic, strong) NSString *lastMonthName;

- (IBAction)OnCategoryChanged:(id)sender;
@end
