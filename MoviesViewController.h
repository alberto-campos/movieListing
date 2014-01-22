//
//  MoviesViewController.h
//  movieListing
//
//  Created by Alberto Campos on 1/19/14.
//  Copyright (c) 2014 Alberto Campos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviesViewController : UITableViewController
{
    UIView *nomatchesView;
    UILabel *matchesLabel; 
}

@property (nonatomic, strong) IBOutlet UILabel *castLabel;


@end
