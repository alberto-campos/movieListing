//
//  MoviesViewController.m
//  movieListing
//
//  Created by Alberto Campos on 1/19/14.
//  Copyright (c) 2014 Alberto Campos. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "Movie.h"
#import "MovieDetailsViewController.h"


@interface MoviesViewController ()
{
    UIRefreshControl *refreshControl;
}


@property (nonatomic, strong) NSArray *movies;

-(void) reload;
-(void) refresh;
-(void) refreshTableView;

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
	
    [self refresh];
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
   // UIImageView *imageView;
    
    NSDictionary *movie = self.movies[indexPath.row];
    
    cell.movieTitleLabel.text = [movie objectForKey:@"title"];
    cell.synopsisLabel.text = [movie objectForKey:@"synopsis"];
    cell.castingLabel.text = @"Casting";
    //cell.castingLabel.text = [movie objectForKey:@"characters"];
    //cell.previewImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[movie objectForKey:@"posters"]]]];

    // print the Posters.profile
    cell.previewImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://content7.flixster.com/movie/11/17/33/11173373_pro.jpg"]]];
    
    return cell;
}




#pragma mark - Private methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *selectedCell = (UITableViewCell *)sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:selectedCell];
    Movie *movie = self.movies[indexPath.row];
    
    NSLog(@"User tapped at index:%i", indexPath.row);
    MovieDetailsViewController *movieDetailsViewController = (MovieDetailsViewController *)segue.destinationViewController;
    movieDetailsViewController.movie = movie;
    
    //NSLog(@"%@ ", movie.casting);
    
}


-(void) refresh
{
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
}


-(void) refreshTableView {
    [self.tableView reloadData];
    NSLog(@"Refreshing data. Please wait.");
    [refreshControl endRefreshing];

}
- (void) reload
{
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSError *error;
        
        NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        
        if (object)
        {
            self.movies = [object objectForKey:@"movies"];
            [self.tableView reloadData];
            
           // NSMutableArray *movies = [NSMutableArray array];
            //for (id moviesDict in [object objectForKey:@"movies"]) {
              //  NSString *title = [moviesDict objectForKey:@"title"];
                //NSString *synopsis = [moviesDict objectForKey:@"synopsis"];
                
                //[movies addObject:title];
               // [movies addObject:synopsis];
                
         //       [movies addObject:[Movie movieTitle:title movieSynopsis:synopsis]];
        
        
        // Movie *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        //self.movies = [object objecForKey:@"movies"];

        }
        else
        {
            //error while retrieving movie listing
            NSLog(@"There was an error while retrieving your movie listing. Check URL and verity that website is available.");
        }
    }];
    NSLog(@"Loading data. Please wait.");
}

@end
