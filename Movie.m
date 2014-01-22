//
//  Movie.m
//  movieListing
//
//  Created by Alberto Campos on 1/19/14.
//  Copyright (c) 2014 Alberto Campos. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        NSDictionary *cast;
         NSString *s = @"";
        
        self.title = dictionary[@"title"];
        self.synopsis = dictionary[@"synopsis"];
        cast = dictionary[@"abridged_cast"];
        
 //
        for (NSString *item in cast)
        {
            NSString *temp = [NSString stringWithFormat:@"%@, ", cast];
            s = [s stringByAppendingString:temp];
            
            NSLog(@"end for loop");
        }
        
        self.cast = s;
        
        //self.title = @"my title";
        //self.synopsis = @"my synopsis";
        
        NSLog(@"%@, %@, %@.", self.title, self.synopsis, self.cast);
    }
    
    return self;
}

- (NSString *) cast {
    
    
   // NSDictionary cast = dictionary[@"abridged_cast"];
    // [self.tableView reloadData];
    
    // NSMutableArray *movies = [NSMutableArray array];
    //for (id moviesDict in [object objectForKey:@"movies"]) {
    //  NSString *title = [moviesDict objectForKey:@"title"];
    //NSString *synopsis = [moviesDict objectForKey:@"synopsis"];
    
    //[movies addObject:title];
    // [movies addObject:synopsis];
    
    //       [movies addObject:[Movie movieTitle:title movieSynopsis:synopsis]];
    
    
    // Movie *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    //self.movies = [object objecForKey:@"movies"];
    
    return self;
}

@end
