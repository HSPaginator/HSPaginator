//
//  HSPageManager.h
//  HSPaginator
//
//  Created by Hardeep on 05/06/15.
//  Copyright (c) 2015 ZeroTechnology. All rights reserved.
//

typedef enum HSPaginatorStatus {
    HSPaginatorStatusBegning,
    HSPaginatorStatusInBetween,
    HSPaginatorStatusEnd
}HSPaginatorStatus;


//------------------------------INPROGRESS
typedef enum HSPaginatorRequestStatus {
    HSPaginatorRequestStatusNone,
    HSPaginatorRequestStatusInProgress,
    HSPaginatorRequestStatusDone,
    HSPaginatorRequestStatusCancel
}HSPaginatorRequestStatus;


#import <Foundation/Foundation.h>

@class HSPageManager;

#import "Paginator.h"

//--------
// Required...
//--------

typedef void (^HSFetchNextPageBlock) (NSInteger pageNumber, NSInteger pageSize);
typedef void (^HSPageSuccessCallBack) (HSPageManager *paginator, id results);
typedef void (^HSPageFailedCallBack) ();
typedef void (^HSLastPageBlock) ();

@interface HSPageManager : NSObject

//----
@property (nonatomic, assign) HSPaginatorRequestStatus requestStatus;

//---
@property (nonatomic, assign) HSPaginatorStatus paginatorStatus;
@property (nonatomic, copy) HSFetchNextPageBlock nextPageBlock;
@property (nonatomic, copy) HSPageFailedCallBack failedBlock;
@property (nonatomic, copy) HSPageSuccessCallBack successBlock;
@property (nonatomic, copy) HSLastPageBlock lastPageBlock;

//--------
@property (nonatomic, assign, readonly) NSInteger resultsCount;
@property (nonatomic, assign, getter = isReachedLastPage) BOOL reachedLastPage;
@property (nonatomic, assign, readonly) NSInteger pageNumber;
@property (nonatomic, assign, readonly) NSInteger pageSize;
@property (nonatomic, assign, readonly) NSInteger totalRecords;

//-----
@property (nonatomic, strong) NSMutableArray *results;

//-----------
- (id)initWithPageSize:(NSInteger )size;
- (id)initWithPageNumber:(NSInteger )pageNumber pageSize:(NSInteger )size;

- (void)setPagination:(HSFetchNextPageBlock )block
              success:(HSPageSuccessCallBack )success;
- (void)setPagination:(HSFetchNextPageBlock )block
              success:(HSPageSuccessCallBack )success
               failed:(HSPageFailedCallBack )failed;

//------------
- (void)fetchNextpage;
- (void)refreshPaginator;

//Update records..
- (void)updateRecords:(NSArray *)results total:(NSInteger )totalRecords;
- (void)failed;

@end
