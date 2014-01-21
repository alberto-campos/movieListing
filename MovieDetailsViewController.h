//
//  MovieDetailsViewController.h
//  movieListing
//
//  Created by Alberto Campos on 1/20/14.
//  Copyright (c) 2014 Alberto Campos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieDetailsViewController : UIViewController
{
    IBOutlet UILabel *titleHeadLabel;
    IBOutlet UILabel *titleALabel;
    IBOutlet UILabel *titleBLabel;
    IBOutlet UILabel *summaryLabel;
    IBOutlet UILabel *summaryDetailsLabel;
    IBOutlet UILabel *castLabel;
    IBOutlet UILabel *castDetailsLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *titleHeadLabel;
@property (nonatomic, retain) IBOutlet UILabel *titleALabel;
@property (nonatomic, retain) IBOutlet UILabel *titleBLabel;
@property (nonatomic, retain) IBOutlet UILabel *summaryLabel;
@property (nonatomic, retain) IBOutlet UILabel *summaryDetailsLabel;
@property (nonatomic, retain) IBOutlet UILabel *castLabel;
@property (nonatomic, retain) IBOutlet UILabel *castDetailsLabel;

@property (strong) Movie *movie;

@end
