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


-(void)getRemainingFromCPP;
-(void)storeProverbsFromCPP;
-(void)storeStopWordsFromCPP;
-(void)removeStopWordsFromCPP;
-(void)createListFromCPP;
//-(void)hashBrownFromCPP:(NSString *) prov;
-(NSString *)removeUserFromCPP:(NSString *) prov;
@end



#endif /* OBCHeader_h */

