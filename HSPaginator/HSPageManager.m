//
//  HSPageManager.m
//  HSPaginator
//
//  Created by Hardeep on 05/06/15.
//  Copyright (c) 2015 ZeroTechnology. All rights reserved.
//

#import "HSPageManager.h"

@interface HSPageManager ()

@property (nonatomic, assign, readwrite) NSInteger pageNumber;
@property (nonatomic, assign, readwrite) NSInteger pageSize;
@property (nonatomic, assign, readwrite) NSInteger totalRecords;

@end;

@implementation HSPageManager

- (id)initWithPageNumber:(NSInteger )pageNumber pageSize:(NSInteger )size {

    self = [super init];

    if (self) {
        self.pageNumber = pageNumber;
        self.pageSize = size;
        self.results = [[NSMutableArray alloc]init];
    }

    return self;

}

- (id)initWithPageSize:(NSInteger )size {
    return [self initWithPageNumber:0 pageSize:size];
}

- (NSInteger)resultsCount {
    return [self.results count];
}

- (NSMutableArray *)results {

    if (!_results) {
        _results = [[NSMutableArray alloc]init];
    }
    return _results;

}

//----
- (void)refreshPaginator {

    self.totalRecords = 0;
    self.pageNumber = 0;
    self.requestStatus = HSPaginatorRequestStatusNone;

    // MakeRqestFor FirsPage;
    self.nextPageBlock(self.pageNumber,self.pageSize);

}

- (void)fetchNextpage {

    // don't do anything if there's already a request in progress
    if(self.requestStatus == HSPaginatorRequestStatusInProgress)
      return;

    self.requestStatus = HSPaginatorRequestStatusInProgress;
    self.nextPageBlock(self.pageNumber++, self.pageSize);

}

//----
- (BOOL)isReachedLastPage {

    if (self.requestStatus == HSPaginatorRequestStatusNone)
     return NO; // if we haven't made a request, we can't know for sure

    NSInteger totalPages = ceil((float)self.totalRecords/(float)self.pageSize);
    return self.pageNumber >= totalPages;
    return YES;

}

- (void)setPagination:(HSFetchNextPageBlock )block
              success:(HSPageSuccessCallBack )success {
    [self setPagination:block success:success failed:nil];
}

- (void)setPagination:(HSFetchNextPageBlock )block
              success:(HSPageSuccessCallBack )success
               failed:(HSPageFailedCallBack )failed {

    self.nextPageBlock = block;
    self.successBlock = success;
    self.failedBlock = failed;

    if (self.isReachedLastPage) {
        return;
    }

    self.requestStatus = HSPaginatorRequestStatusInProgress;
    if (self.nextPageBlock) {
        self.nextPageBlock(self.pageNumber++,self.pageSize);
    }

}


- (void)updateRecords:(NSArray *)results total:(NSInteger)total {

    //Module 2
    if (self.results.count && (self.totalRecords == 0) && (self.pageNumber == 1)) {
       [self.results removeAllObjects];
     }

    [self.results addObjectsFromArray:results];
     self.totalRecords = total;
     self.requestStatus = HSPaginatorRequestStatusDone;

  //--------
    if (self.successBlock) {
        self.successBlock(self,results);
    }

}

//----


- (void)failed {
    self.requestStatus = HSPaginatorRequestStatusDone;
    if (self.failedBlock) {
        self.failedBlock();
    }
}

@end
