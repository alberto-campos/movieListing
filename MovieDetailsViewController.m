//
//  MovieDetailsViewController.m
//  movieListing
//
//  Created by Alberto Campos on 1/20/14.
//  Copyright (c) 2014 Alberto Campos. All rights reserved.
//

#import "MovieDetailsViewController.h"

@interface MovieDetailsViewController ()

- (void)reload;

@end

@implementation MovieDetailsViewController


@synthesize titleHeadLabel, titleALabel, titleBLabel, summaryLabel, summaryDetailsLabel, castLabel, castDetailsLabel, mainImage, movie;

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
	   
    self.title = self.movie.title;
    self.titleALabel.text = self.movie.title;
    self.titleBLabel.text = self.movie.title;
    
    self.summaryLabel.text = @"Summary";
    self.summaryDetailsLabel.text = self.movie.synopsis;
    
    self.castLabel.text = @"Cast";
    self.castDetailsLabel.text = self.movie.cast;
    
    self.mainImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.movie.image]]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self reload];
    }
    return self;
}


#pragma mark - Private methods

- (void)reload
{
    
}

@end
