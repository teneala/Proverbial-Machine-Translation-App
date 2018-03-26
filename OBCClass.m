//
//  OBCClass.m
//  trans
//
//  Created by Teneala Spencer on 3/20/18.
//  Copyright © 2018 Teneala Spencer. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OBCHeader.h"
#import "Store.hpp"



using namespace std;


@implementation OBCClass



-(NSString *)removeUserFromCPP:(NSString *) prov{
    std::string objProv([prov UTF8String]);
    std::string res([prov UTF8String]);
    house call;
    call.removeUser(objProv);
    res = call.hashBrown(objProv);
    
  
    NSString* result = [NSString stringWithUTF8String:res.c_str()];

    return result;
    
}



- (void)storeStopWordsFromCPP{
    house call;
    call.storeStopWords();
    
}

- (void)storeProverbsFromCPP{
    house call;
    call.storeProverbs();
    
}


-(void)getRemainingFromCPP{
    house call;
    call.getRemaining();
}

-(void)removeStopWordsFromCPP{
    house call;
    call.removeStopWords();
}

-(void)createListFromCPP{
    house call;
    call.createList();
}


@end

