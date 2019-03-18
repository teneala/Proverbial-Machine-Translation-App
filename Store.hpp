//
//  Store.hpp
//  trans
//
//  Created by Teneala Spencer on 3/20/18.
//  Copyright © 2018 Teneala Spencer. All rights reserved.
//
#ifdef _cplusplus

extern "C" {
 
#endif
    
    
#ifndef Store_hpp
#define Store_hpp
#include <stdio.h>
#include <sstream>

#include <string>
    
    using namespace std;
    class house
    {
    public:
        house();
        ~house();
        
        void getRemaining();
        void storeIngles();
        void storeProverbs();
        void storeStopWords();
        void removeStopWords();
        void createList();
        void createLink();
        void getUserStuff();
        void storeStopIngles();
        void deleteHash();
        string returnProv(string pro);
        string ifNotFound(std::string prov, int c, int keyys);
        string hashBrown(std::string prov);
        string removeUser(std::string prov);
        
        
        
        
    };
    
    
#ifdef _cplusplus
}
#endif
#endif
