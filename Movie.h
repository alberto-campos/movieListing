//
//  Movie.h
//  movieListing
//
//  Created by Alberto Campos on 1/19/14.
//  Copyright (c) 2014 Alberto Campos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *synopsis;
@property (nonatomic, strong) NSString *casting;

- (id)initWithDictionary:(NSDictionary *)dictionary;


@end
