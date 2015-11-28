//
//  HSTableView.m
//  HSPaginator
//
//  Created by Hardeep on 06/06/15.
//  Copyright (c) 2015 ZeroTechnology. All rights reserved.
//

#import "HSTableView.h"
#import "HSFotterView.h"

@interface HSTableView ()<UIScrollViewDelegate>

@property (nonatomic, strong) HSFotterView *fotterView;
@property (nonatomic, weak, readwrite) HSPageManager *pageManager;
@property (nonatomic, weak, readwrite) HSPageManager *strongPager;
@property (nonatomic, strong, readwrite) NSMutableArray *results;

@end

@implementation HSTableView

@synthesize pageManager = _pageManager;

///---
- (id)initWithCoder:(NSCoder *)aDecoder {

    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupFotterView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupFotterView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setupFotterView];
    }
    return self;
}

- (void)setupFotterView {

    HSFotterView *fotterView = [[[NSBundle mainBundle]loadNibNamed:@"HSFotterView" owner:nil options:nil]objectAtIndex:0];
    fotterView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 50);
    fotterView.backgroundColor = [UIColor orangeColor];
    self.tableFooterView = fotterView;
  //  fotterView = nil;

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    NSInteger contentY =   scrollView.contentOffset.y;
    NSInteger scrollHeight =   scrollView.contentSize.height - scrollView.bounds.size.height;

    switch (self.nextPageOn) {

        case HSNextPageOnDisplayFotter:
        {
            if (contentY == scrollHeight){
                [self.pageManager fetchNextpage];
            }
        }
            break;
        case HSNextPageOnTap:
        {

        }
            break;
        case HSNextPageOnPull:
        {

        }
            break;

        default:
            break;
    }

}

//----
//----

- (NSMutableArray *)results {
    return self.pageManager.results;
}

- (NSInteger)totalRecords {
    return self.pageManager.totalRecords;
}

- (NSInteger)pageSize {
    return self.pageManager.pageSize;
}

- (NSInteger)pageNumber {
    return self.pageManager.pageNumber;
}

#pragma mark -
#pragma mark - Set Pagger Block
#pragma mark -

- (void)setNextPageBlock:(HSFetchNextPageBlock )block {

    if (self.pageManager.nextPageBlock != block) {
        self.pageManager.nextPageBlock = block;
    }

}

- (void)setSuccessBlock:(HSPageSuccessCallBack )block {

    if (self.pageManager.successBlock != block) {
        self.pageManager.successBlock = block;
    }

}

- (void)setFailedBlock:(HSPageFailedCallBack )block {

    if (self.pageManager.failedBlock != block) {
        self.pageManager.failedBlock = block;
    }

}

- (void)setLastPageBlock:(HSLastPageBlock )block {
    if (self.pageManager.lastPageBlock != block) {
        self.pageManager.lastPageBlock = block;
    }
}

#pragma mark -
#pragma mark - Create New Pager
#pragma mark -

//- (HSPageManager *)setPager:(NSInteger)size
//                   nextPage:(HSFetchNextPageBlock )next
//                    success:(HSPageSuccessCallBack )success
//                     failed:(HSPageFailedCallBack)failed
//                   lastPage:(HSLastPageBlock)lastPage {
//
//
//}

- (HSPageManager *)setPagination:(NSInteger )page
                        pageSize:(NSInteger )size
                        nextPage:(HSFetchNextPageBlock )next {

        HSPageManager *pageManager = [[HSPageManager alloc]initWithPageNumber:page pageSize:size];

       //Weak refrence..
       self.pageManager = pageManager;

         //
        [self setNextPageBlock:next];
        [self.pageManager fetchNextpage];
         //retrun weak reference.
        return pageManager;

}

- (void)setPaginator:(HSPageManager *)pageManager
            nextPage:(HSFetchNextPageBlock )next
             success:(HSPageSuccessCallBack )success
              failed:(HSPageFailedCallBack)failed
            lastPage:(HSLastPageBlock)lastPage {

    //Give strong reference..
    self.strongPager = pageManager;

    //----
    [self setNextPageBlock:next];
    [self setSuccessBlock:success];
    [self setFailedBlock:failed];
    [self setLastPageBlock:lastPage];
    [self.pageManager fetchNextpage];

}


#pragma mark -
#pragma mark - Switch Paginator
#pragma mark -

// strong page will give also reference to weak object..

- (void)setStrongPager:(HSPageManager *)strongPager {
    if (_strongPager != strongPager){
        _strongPager = strongPager;
        self.pageManager = strongPager;
    }
}

// weak pagemanager object
- (void)setPageManager:(HSPageManager *)pageManager {
    if (_pageManager != pageManager) {
        _pageManager = pageManager;
    }
}

- (HSPageManager *)pageManager {
    return _pageManager;
}

- (void)switchPaginator:(HSPageManager *)paggerManager {

    if (_pageManager != paggerManager) {
        paggerManager.lastPageBlock = _pageManager.lastPageBlock;
        paggerManager.nextPageBlock = _pageManager.nextPageBlock;
        paggerManager.successBlock = _pageManager.successBlock;
        paggerManager.failedBlock = _pageManager.failedBlock;
        _pageManager = paggerManager;
        [self reloadData];
    }

}

@end
