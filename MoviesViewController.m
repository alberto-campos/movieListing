//
//  MoviesViewController.m
//  movieListing
//
//  Created by Alberto Campos on 1/19/14.
//  Copyright (c) 2014 Alberto Campos. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"

@interface MoviesViewController ()

@property (nonatomic, strong) NSArray *movies;

-(void)reload;

@end

@implementation MoviesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self reload];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self reload];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view methods

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieCell *cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    NSDictionary *movie = self.movies[indexPath.row];
    
    cell.movieTitleLabel.text = [movie objectForKey:@"title"];
    cell.synopsisLabel.text = [movie objectForKey:@"synopsis"];
    cell.castingLabel.text = @"Casting";
    //cell.castingLabel.text = [movie objectForKey:@"characters"];
    return cell;
}

#pragma mark - Private methods

- (void)reload
{
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        self.movies = [object objectForKey:@"movies"];
        
        [self.tableView reloadData];
    }];
}

@end
