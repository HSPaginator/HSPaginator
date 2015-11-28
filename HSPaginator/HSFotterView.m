//
//  HSFotterView.m
//  HSPaginator
//
//  Created by Hardeep on 06/06/15.
//  Copyright (c) 2015 ZeroTechnology. All rights reserved.
//

#import "HSFotterView.h"

@interface HSFotterView ()

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) UILabel *resultsLabel;

@end

@implementation HSFotterView

- (id)initWithCoder:(NSCoder *)aDecoder {

    self = [super initWithCoder:aDecoder];

    if (self) {

    }

    return self;
    
}

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];

    if (self) {


    }

    return self;
}

- (void)layoutSubviews {

    [super layoutSubviews];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
