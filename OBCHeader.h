//
//  OBCHeader.h
//  trans
//
//  Created by Teneala Spencer on 3/20/18.
//  Copyright © 2018 Teneala Spencer. All rights reserved.
//

    
#ifndef OBCHeader_h
#define OBCHeader_h
    
    
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
    

    
@interface OBCClass: NSObject
// [getBusStops: arg1 forTime: arg2]

-(NSString *)removeUser:(NSString *) prov FromCPP: (int)provCount Additional: (NSString*) flag;
-(NSString *)storeStopWordsFromCPP:(NSString *) prov;
-(NSString*)storeProverbs:(NSString *) prov FromCPP: (NSString *)store Additional: (NSString*) flag;
-(NSString*)storeIngles:(NSString *) prov FromCPP: (NSString *)store Additional: (NSString*) flag;
-(NSString*)storeStopInglesFromCPP:(NSString *) prov;


//-(void)storeProverbsFromCPP;
//-(void)storeStopWordsFromCPP;

-(void)removeStopWordsFromCPP;
//-(void)createListFromCPP;
-(void)getRemainingFromCPP;
-(void)houze;





@end



#endif /* OBCHeader_h */

