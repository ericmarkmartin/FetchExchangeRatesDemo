//
//  ExchangeRate.h
//  ExchangeRateDemo
//
//  Created by Vanilla Wafer on 7/2/14.
//  Copyright (c) 2014 Michael Shafae. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExchangeRate : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{
    NSMutableData *_asyncRequestData;
}
@property (readonly, retain, nonatomic) NSNumber* ratioToUSDollar;
@property (readonly, retain, nonatomic) NSString* conversionID;
@property (readonly, retain, nonatomic) NSString* name;
//@property (retain, nonatomic) UIImage* flagImage;
@property (readonly, retain, nonatomic) NSDate* lastFetchedOn;



-(ExchangeRate*) initWithConversionID: (NSString*) aConversionID Name: (NSString*) aName;
-(void) update;


//-(NSString*) description;

@end
