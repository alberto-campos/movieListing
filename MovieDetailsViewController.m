//
//  MovieDetailsViewController.m
//  movieListing
//
//  Created by Alberto Campos on 1/20/14.
//  Copyright (c) 2014 Alberto Campos. All rights reserved.
//

#import "MovieDetailsViewController.h"

@interface MovieDetailsViewController ()

@end

@implementation MovieDetailsViewController


@synthesize titleHeadLabel, titleALabel, titleBLabel, summaryLabel, summaryDetailsLabel, castLabel, castDetailsLabel, movie;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
   // self.titleHeadLabel.text = movie.title;
    self.summaryDetailsLabel.text = movie.synopsis;
    self.titleALabel.text = movie.title;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end