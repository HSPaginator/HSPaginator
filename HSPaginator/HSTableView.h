//
//  HSTableView.h
//  HSPaginator
//
//  Created by Hardeep on 06/06/15.
//  Copyright (c) 2015 ZeroTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSPageManager.h"

typedef enum HSNextPageOn {
    HSNextPageOnDisplayFotter,
    HSNextPageOnTap,
    HSNextPageOnPull
}HSNextPageOn;

@interface HSTableView : UITableView


@property (nonatomic, weak, readonly) HSPageManager *pageManager;

@property (nonatomic, assign, readonly) HSNextPageOn nextPageOn;

@property (nonatomic, assign, readonly) NSInteger pageNumber;
@property (nonatomic, assign, readonly) NSInteger pageSize;
@property (nonatomic, readonly, readonly) NSInteger totalRecords;

- (NSMutableArray *)results;

- (void)switchPaginator:(HSPageManager *)paggerManager;


// return weak HSPageManager....
// You must assign to strong object.
- (HSPageManager *)setPagination:(NSInteger )page
                        pageSize:(NSInteger )size
                        nextPage:(HSFetchNextPageBlock )next;

// Retain object as Strong...
- (void)setPaginator:(HSPageManager *)paggerManager
            nextPage:(HSFetchNextPageBlock )block
             success:(HSPageSuccessCallBack )success
              failed:(HSPageFailedCallBack )failed
            lastPage:(HSLastPageBlock )lastPage;

- (void)setNextPageBlock:(HSFetchNextPageBlock )block;
- (void)setSuccessBlock:(HSPageSuccessCallBack )block;
- (void)setFailedBlock:(HSPageFailedCallBack )block;
- (void)setLastPageBlock:(HSLastPageBlock )block;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end
