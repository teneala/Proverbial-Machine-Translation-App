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



-(NSString *)removeUser:(NSString *) prov FromCPP: (int) provCount Additional: (NSString*) flag{
    std::string objProv([prov UTF8String]);
    std::string res([prov UTF8String]);
    std::string dialectFlag([flag UTF8String]);

    house call;
    res =  call.removeUser(objProv, provCount, dialectFlag);
    

    NSString* result = [NSString stringWithUTF8String:res.c_str()];

    return result;
    
}
- (NSString*)storeIngles:(NSString *) prov FromCPP: (NSString *)store Additional: (NSString*) flag{
    std::string objProv([prov UTF8String]);
    std::string objProv2([store UTF8String]);
    std::string dialectFlag([flag UTF8String]);
    //std::string keyword[15];
    NSString* result = [NSString stringWithUTF8String:objProv.c_str()];
    
    house call;
    
    call.storeIngles(objProv, objProv2, dialectFlag);
    
    return result;
    
}

-(NSString*)storeStopInglesFromCPP:(NSString *) prov Additional: (NSString*) flag{
    std::string objProv([prov UTF8String]);
    house call;
    call.storeStopIngles(objProv);
    NSString* result = [NSString stringWithUTF8String:objProv.c_str()];
    return result;

}

//- (void)storeStopWordsFromCPP{
-(NSString *)storeStopWordsFromCPP:(NSString *) prov{
    std::string objProv([prov UTF8String]);
    house call;
    call.storeStopWords(objProv);
    NSString* result = [NSString stringWithUTF8String:objProv.c_str()];

    return result;
}

//-(NSString *)storeProverbs:(NSString *) prov FromCPP: (NSString *)store;

-(NSString *)storeProverbs:(NSString *) prov FromCPP: (NSString *)store Additional: (NSString*) flag{
//- (void)storeProverbsFromCPP{
    std::string objProv([prov UTF8String]);
    std::string objProv2([store UTF8String]);
    std::string dialectFlag([flag UTF8String]);
    //std::string originalPhrs([original UTF8String]);
    NSString* result = [NSString stringWithUTF8String:objProv.c_str()];

    
    house call;
    call.storeProverbs(objProv, objProv2, dialectFlag);
    return result;
}


-(void)getRemainingFromCPP{
    house call;
    call.getRemaining();
}

-(void)removeStopWordsFromCPP{
    house call;
    call.removeStopWords();
}

/*-(void)createListFromCPP{
    house call;
    std::string keyword[15];

    call.createList();
}*/

-(void)houze{
    house call;
    call.house::~house();
}
@end

