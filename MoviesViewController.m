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
#import "MovieDetailsViewController.h"
#import "MoviesArray.h"
#import "SVProgressHUD.h"


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

   [SVProgressHUD showWithStatus:@"Retrieving movie results..."];
    
    nomatchesView = [[UIView alloc] initWithFrame:self.view.frame];
    nomatchesView.backgroundColor = [UIColor clearColor];
    
    matchesLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,320,120)];
    matchesLabel.font = [UIFont boldSystemFontOfSize:18];
    matchesLabel.numberOfLines = 1;
    matchesLabel.shadowColor = [UIColor lightTextColor];
    matchesLabel.textColor = [UIColor darkGrayColor];
    matchesLabel.shadowOffset = CGSizeMake(0, 1);
    matchesLabel.backgroundColor = [UIColor clearColor];
    matchesLabel.textAlignment = NSTextAlignmentCenter;
    
    
    //Here is the text for when loading data or there are no results
    matchesLabel.text = @"Searching for movies...";
    
    
    nomatchesView.hidden = YES;
    [nomatchesView addSubview:matchesLabel];
    [self.tableView insertSubview:nomatchesView belowSubview:self.tableView];
    
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
    //If there is no table data, unhide the "No matches" view
    if(self.movies.count == 0 )
    {
        nomatchesView.hidden = NO;
    }
    else
    {
        nomatchesView.hidden = YES;
    }
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    MovieCell *cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    MoviesArray *movie = self.movies[indexPath.row];
    cell.movieTitleLabel.text = movie.title;
    cell.synopsisLabel.text = movie.synopsis;
    cell.castingLabel.text = movie.cast;
    cell.previewImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:movie.image]]];
    [SVProgressHUD dismiss];
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
    
    NSLog(@"prepare for Segue.");
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
    
   // [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
         
         // checking connectivity
         if (!connectionError && statusCode == 200)
         {
            NSError *error;
            NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];            
            
            if (object)
            {
                NSMutableArray *movies = [[NSMutableArray alloc] init];
                for(NSDictionary *movie in [object objectForKey:@"movies"]){
                    NSMutableDictionary *movieWithDetails = [[NSMutableDictionary alloc] init];
                    for(NSDictionary *casting in movie[@"abridged_cast"])
                    {
                        if([movieWithDetails objectForKey:@"cast"])
                        {
                            NSMutableArray *cast = [movieWithDetails objectForKey:@"cast"];
                            [cast addObject:casting[@"name"]];
                            [movieWithDetails setObject:cast forKey:@"cast"];
                        }
                        else
                        {
                            NSMutableArray *cast = [[NSMutableArray alloc] init];
                            [cast addObject:casting[@"name"]];
                            [movieWithDetails setObject:cast forKey:@"cast"];
                        }
                        
                    }
                    [movieWithDetails setObject:movie[@"title"] forKey:@"title"];
                    [movieWithDetails setObject:movie[@"synopsis"] forKey:@"synopsis"];
                    [movieWithDetails setObject:movie[@"posters"][@"original"] forKey:@"image"];
                    MoviesArray *movieElement= [[MoviesArray alloc] initWithDictionary:movieWithDetails];
                    [movies addObject:movieElement];
                }
                
                self.movies = movies;
                [self.tableView reloadData];
                
            }
            else
            {
                //error while retrieving movie listing
                NSLog(@"There was an error while retrieving your movie listing. Check URL and verity that website is available.");
            }
             
         } // end IF cheking connectivity
         else
         {
             //error while retrieving movie listing
             NSLog(@"There was an error while retrieving your movie listing. Try again.");
         }
    }];
    NSLog(@"Loading data. Please wait.");
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    
    
}

@end
