//
//  ExchangeRate.m
//  ExchangeRateDemo
//
//  Created by Vanilla Wafer on 7/2/14.
//  Copyright (c) 2014 Michael Shafae. All rights reserved.
//

#import "ExchangeRate.h"

@interface ExchangeRate ()

@end


@implementation ExchangeRate
@synthesize ratioToUSDollar;
@synthesize conversionID;
@synthesize name;
@synthesize lastFetchedOn;

-(ExchangeRate*) initWithConversionID: (NSString*) aConversionID Name: (NSString*) aName;
{
    self = [super init];
    if ( self ){
        conversionID = aConversionID;
        name = aName;
        lastFetchedOn = [NSDate date];
    }
    return self;
}


-(void) update
{
    // Return YES if updated successfully
    // or return NO if update failed
    NSString *yqlRestQuery = @"https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.xchange%20where%20pair%20in%20(%22USDconversionID%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=";
    yqlRestQuery = [yqlRestQuery stringByReplacingOccurrencesOfString:@"conversionID" withString:conversionID];
    NSLog(@"%@",yqlRestQuery);
    
    NSURL *yqlFetchUrl = [NSURL URLWithString:yqlRestQuery];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:yqlFetchUrl];
    
    NSURLConnection *rateFetch = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    //    [rateFetch scheduleInRunLoop:[NSRunLoop mainRunLoop]
    //                          forMode:NSDefaultRunLoopMode];
    //    [rateFetch start];
}

-(NSString*) description
{
    // ExchangeRate: ratio is 0.73 for Costa Rica last fetched on March 5, 2012 (so CA$1 is CR$.73)
    return [NSString stringWithFormat: @"ExchangeRate: ratio is %g for %@ %@ last fetched on %@", self.ratioToUSDollar.floatValue, self.conversionID, self.name, self.lastFetchedOn.description];
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _asyncRequestData = [[NSMutableData alloc]init];
    
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"didReceiveData");
    // Append the new data to the instance variable you declared
    [_asyncRequestData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse
{
    NSLog(@"cachedResponse");
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"didfinishloading");
    id unknownObject = [NSJSONSerialization JSONObjectWithData:_asyncRequestData options:0 error:nil];
    
    NSDictionary *exchangeRatesDictionary;
    
    if( [unknownObject isKindOfClass: [NSDictionary class]]){
        exchangeRatesDictionary = unknownObject;
    }else{
        exchangeRatesDictionary = nil;
    }
    
    NSArray *exchangeRatesDictionaryList = [[[exchangeRatesDictionary valueForKey: @"query"] valueForKey:@"results"] valueForKey: @"rate"];
    //    NSMutableArray *exchangeRateObjectList = [[NSMutableArray alloc] init];
    //    for(NSDictionary *exchangeRateDictionary in exchangeRatesDictionaryList){
    //        ExchangeRate *m = [[ExchangeRate alloc] initWithRatioToUSDollar: [NSNumber numberWithFloat: [[exchangeRateDictionary valueForKey: @"Rate"] floatValue]] ConversionID: [exchangeRateDictionary valueForKey: @"id"] Name: [exchangeRateDictionary valueForKey: @"Name"]];
    //}
    NSNumber *xchngRate = [NSNumber numberWithFloat:[[exchangeRatesDictionaryList valueForKey:@"Rate"] floatValue]];
    NSLog(@"%f",[xchngRate floatValue]);
    if ([xchngRate isKindOfClass:[NSNumber class]])
    {
        ratioToUSDollar = xchngRate;
    }
    lastFetchedOn = [NSDate date];
}



- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error");
    NSLog(@"Error with connection!");
}

@end
