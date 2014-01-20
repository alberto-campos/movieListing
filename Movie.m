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
        self.title = dictionary[@"title"];
        self.synopsis = dictionary[@"synopsis"];
    }
    
    return self;
}

- (NSString *) casting {
    return self;
}

@end
