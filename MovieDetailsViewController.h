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

@property (nonatomic, weak) IBOutlet UILabel *titleHeadLabel;
@property (nonatomic, weak) IBOutlet UILabel *titleALabel;
@property (nonatomic, weak) IBOutlet UILabel *titleBLabel;
@property (nonatomic, weak) IBOutlet UILabel *summaryLabel;
@property (nonatomic, weak) IBOutlet UILabel *summaryDetailsLabel;
@property (nonatomic, weak) IBOutlet UILabel *castLabel;
@property (nonatomic, weak) IBOutlet UILabel *castDetailsLabel;

@property (strong) Movie *movie;

@end
