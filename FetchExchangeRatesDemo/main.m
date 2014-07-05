//
//  main.m
//  FetchExchangeRatesDemo
//
//  Created by Michael Shafae on 7/3/14.
//  Copyright (c) 2014 Michael Shafae. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExchangeRate.h"

// Yahoo Query Language Console:
// https://developer.yahoo.com/yql/console/
// Yahoo Query Language:
// select * from yahoo.finance.xchange where pair in ("USDEUR", "USDCNY", "USDLBP", "USDRUB", "USDMXN")
// Permalink:
// http://developer.yahoo.com/yql/console/?q=select%20*%20from%20yahoo.finance.xchange%20where%20pair%20in%20(%22USDEUR%22%2C%20%22USDCNY%22%2C%20%22USDLBP%22%2C%20%22USDRUB%22%2C%20%22USDMXN%22)&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys
// REST JSON Query
// https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.xchange%20where%20pair%20in%20(%22USDEUR%22%2C%20%22USDCNY%22%2C%20%22USDLBP%22%2C%20%22USDRUB%22%2C%20%22USDMXN%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=
//int main(int argc, const char * argv[])
//{
//
//  @autoreleasepool {
//    NSString *yahooFinanaceURLString = @"https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.xchange%20where%20pair%20in%20(%22USDconversionID%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=";
//    NSURL *yahooFinanaceRESTQueryURL = [NSURL URLWithString: yahooFinanaceURLString];
//
//    NSURLRequest *request = [NSURLRequest requestWithURL: yahooFinanaceRESTQueryURL];
//
//    NSURLResponse *response = nil;
//    NSError *error = nil;
//
//    NSData *yahooFinanaceQueryResults = [NSURLConnection sendSynchronousRequest: request returningResponse: &response error: &error];
//
//    if (!error){
//      NSLog(@"Connection and request completed without an error %@", response);
//    }else{
//      NSLog(@"Error with connection!");
//      return 1;
//    }
//
//    id unknownObject = [NSJSONSerialization
//                 JSONObjectWithData: yahooFinanaceQueryResults
//                 options: 0
//                 error: &error];
//
//    NSDictionary *exchangeRatesDictionary;
//
//    if (!error) {
//      NSLog(@"Loaded JSON Data Successfully");
//      if( [unknownObject isKindOfClass: [NSDictionary class]]){
//        exchangeRatesDictionary = unknownObject;
//      }else{
//        exchangeRatesDictionary = nil;
//      }
//    }else{
//      NSLog(@"There was an unfortunate error; nothing was loaded.");
//      return 1;
//    }
//    
//    NSArray *exchangeRatesDictionaryList = [[[exchangeRatesDictionary valueForKey: @"query"] valueForKey:@"results"] valueForKey: @"rate"];
//    NSMutableArray *exchangeRateObjectList = [[NSMutableArray alloc] init];
//    for(NSDictionary *exchangeRateDictionary in exchangeRatesDictionaryList){
//      ExchangeRate *m = [[ExchangeRate alloc] initWithRatioToUSDollar: [NSNumber numberWithFloat: [[exchangeRateDictionary valueForKey: @"Rate"] floatValue]] ConversionID: [exchangeRateDictionary valueForKey: @"id"] Name: [exchangeRateDictionary valueForKey: @"Name"]];
//      [exchangeRateObjectList insertObject: m atIndex: 0];
//      NSLog(@"%@", m);
//    }
//  }
//    return 0;
//}

int main(int argc, const char *argv[])
{
    @autoreleasepool
    {
        ExchangeRate *euro = [[ExchangeRate alloc] initWithConversionID:@"EUR" Name:@"Euro"];
        [euro update];
//        while (!euro.ratioToUSDollar) {
//            NSLog(@"Waiting");
//        }
        NSLog(@"%@",euro.ratioToUSDollar);
    }
}
