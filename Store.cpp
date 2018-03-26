//
//  Store.cpp
//  trans
//
//  Created by Teneala Spencer on 3/20/18.
//  Copyright © 2018 Teneala Spencer. All rights reserved.
//

#ifdef _cplusplus
extern "C" {
#endif
    
#include "Store.hpp"
#include<iostream>
#include <functional>
#include<fstream>
#include <sstream>
#include <string>
    
    using namespace std;
    
    
    
    
    struct node // create data structure to hold proverb information
    {
        string hashWord;
        string * remaining = new string[15]; // used to store remaining keywords that weren't hashed
        string engEquiv;
        node * next = NULL;  // pointer to next is necessary in order to create a linked list from the place in the array where two words are hashed
        
    };
    
    
    node * hashTable = new node[6000]; // create an array of nodes to store proverbs
    
    node * n; // used to create new nodes
    
    node * temp; // used to create linked list
    
    
    string currentKey = ""; // represents the word to be hashed
    
    string filter = ""; //Is used when iterating through the phrase to know whether or not the word that was hashed appears in phrase
    
    string * stopwords  = new string[3231]; // a hash table to store stop words
    
    string word; // used to read in stop words from file
    
    string* keywords = new string [15]; // used to store keywords from proverb
    
    string phrase; //used to read in proverbs from a file
    
    string storedProv; // used to read in english equivalent from file
    
    string prov;
    
    
    int tableSize = 3179; // size proverbs hash table
    
    int indx; // used to compute the index after hashing
    
    int hashS = 0; // used to hash
    
    int size = 319; // size of stop words hash table
    
    int counter = 0;
    
    int i = 0;
    
    
    ifstream stopWords; // stop words file
    ifstream provInput; // proverbs file
    ifstream equivInput; // english equivalent file
    
    ofstream result;
    
    
    /*void house::getprov()
     {
     cout << "Enter a proverb: " << endl << endl;
     getline(cin, prov);
     
     removeUser();
     hashBrown();
     
     }*/
    
    string house::removeUser(string prov)
    {
        string removing;
        stringstream getKey(prov); // Insert the proverb into a stream that was read from the proverbs file
        
        while (getKey >> removing) // While not at the end of the phrase
            
        {
            
            hashS = 0;
            
            for (int i = 0; i < removing.length(); i++) // iterate throught the current words from the phrase
                
            {
                
                hashS = (hashS << 4) + (int)removing[i]; // compute a hash value for that word
                
            }
            
            indx = hashS;
            indx = abs(indx % size); // modules as before
            
            if(stopwords[indx] == removing) // if the value that was produced by hashing the word from the phrase matches whats in the stop words table remove it
            {
                
                std::size_t found = prov.find(removing); // finds the position of the word in the sentence and puts into the integer found
                
                if( found != string::npos) // make sure that this position isn't equal to end of string which by default is set to the value of found if nothing is found
                {
                    prov.erase(found, 3); // erase the word the three is for the spaces
                    
                }
                
            }
            
            
        }
        
        //hashBrown(string prov);
        
        hashBrown(prov);
        
        return prov;
        
    }
    
    
    string house::hashBrown(string prov)
    {
        bool flag = false;
        int keys = 0;
        int c = 0;
        string res;
        
        
        stringstream getKey(prov); // Insert the phrase into a stream
        
        while (getKey >> currentKey && flag != true) // the current key represents the current keyword that is to be hashed and stored with its respective data
            
        {
            if(keys >= 2)
            {
                cout << hashTable[indx].engEquiv;

                res = hashTable[indx].engEquiv;
                result.open("/Users/tenealaspencer/Library/Developer/Xcode/DerivedData/TransVerb_One-bdpetzzxtcbuwedbxdijsndfaiza/Build/Products/Debug/result.txt");
                
                result << res;
                
                cout << endl << "La traduccion es: " << endl << endl << hashTable[indx].engEquiv << endl << endl;
                break;
                
                
            }
            hashS = 0; // resets the value that is created whenever hashing a new word for each new word
            
            for (int i = 0; i < currentKey.length(); i++) // is used to iterate through the string
                
            {
                
                hashS = (hashS << 4) + (int)currentKey[i]; // does a bit operation and shifts them by the size of an integer
                
            }
            
            indx = hashS; // sets indx location equal to hash
            indx = abs(indx % tableSize); // modules the indx by the table size
            
            if(currentKey == hashTable[indx].hashWord )
            {
                cout << hashTable[indx].hashWord;
                stringstream finder(prov);
                
                while (finder >> filter) // while not at end of phrase get remaining
                    
                {
                    
                    
                    for(c = 0; c < counter; c++)
                    {
                        if(hashTable[indx].remaining[c] == filter)
                        {
                            keys++;
                            c++;
                        }
                    }
                }
                
                
            }
            
            
            
        }
        prov = res;
        return prov;
        
    }
    
    
    
    
    void::house::storeProverbs()
    {
        
        provInput.open("/Users/tenealaspencer/Library/Developer/Xcode/DerivedData/trans3-hhytnqxxkhrrlvajlsbdnxevlrug/Build/Products/Debug-iphonesimulator/proverbs.txt"); // opens the proverbs text file
        equivInput.open("/Users/tenealaspencer/Library/Developer/Xcode/DerivedData/trans3-hhytnqxxkhrrlvajlsbdnxevlrug/Build/Products/Debug-iphonesimulator/stored.txt"); // opens the stored (English) proverbs text file
        
        while(provInput) // while not at the end of the proverbs file
            
        {
            getline(provInput, phrase); // read proverbs in line by line
            getline(equivInput, storedProv); // read english proverbs in line by line
            
            
            removeStopWords(); // calls the function to remove the stop words from the file
            
            stringstream getKey(phrase); // Insert the phrase into a stream
            
            
            while (getKey >> currentKey) // the current key represents the current keyword that is to be hashed and stored with its respective data
                
            {
                
                
                hashS = 0; // resets the value that is created whenever hashing a new word for each new word
                
                for (int i = 0; i < currentKey.length(); i++) // is used to iterate through the string
                    
                {
                    
                    hashS = (hashS << 4) + (int)currentKey[i]; // does a bit operation and shifts them by the size of an integer
                    
                }
                
                
                
                indx = hashS; // sets indx location equal to hash
                indx = abs(indx % tableSize); // modules the indx by the table size
                
                
                
                
                if (hashTable[indx].hashWord != "") //checks to see if that index already has been filled
                {
                    createList(); // if so calls this function  to create a linked list from that location
                }
                
                
                
                hashTable[indx].hashWord = currentKey; // sets the words that is being hashed equal to that place in the hash table that holds the hash word
                getRemaining();
                
                for( int j = 0; j <= counter; j++) // counter was incremented to see how many remaining key words there were to know how much to fill that table by
                {
                    
                    hashTable[indx].remaining[j] = keywords[j]; // iterate through the keywords array to get the rest of the key words
                    
                    
                }
                
                
                hashTable[indx].engEquiv = storedProv; // gets the english equivalent from the file and reads it into that part of the array
                
            }
            
        }
        
    }
    
    
    
    void::house::removeStopWords( )
    {
        string removing;
        stringstream getKey(phrase); // Insert the proverb into a stream that was read from the proverbs file
        
        while (getKey >> removing) // While not at the end of the phrase
            
        {
            
            hashS = 0;
            
            for (int i = 0; i < removing.length(); i++) // iterate throught the current words from the phrase
                
            {
                
                hashS = (hashS << 4) + (int)removing[i]; // compute a hash value for that word
                
            }
            
            indx = hashS;
            indx = abs(indx % size); // modules as before
            
            if(stopwords [indx] == removing) // if the value that was produced by hashing the word from the phrase matches whats in the stop words table remove it
            {
                
                std::size_t found = phrase.find(removing); // finds the position of the word in the sentence and puts into the integer found
                
                if( found != string::npos) // make sure that this position isn't equal to end of string which by default is set to the value of found if nothing is found
                {
                    phrase.erase(found, 3); // erase the word the three is for the spaces
                    
                }
                
            }
            
            
        }
        
        
        
    }
    
    
    
    void house::createList()
    {
        
        
        
        if(hashTable[indx].hashWord != "" && hashTable[indx].next == NULL) // ok so this is for if there has already been a node created. if there has been an 'initial' node from the hash table then its gonna do this:
        {
            n = new node; // create a new node
            
            hashTable[indx].next = n;
            
            n -> hashWord = currentKey; // set the current word that is being hashed equal to hashword for that particular data
            
            getRemaining(); // removes the hash word from the other key words
            
            for (int i = 0; i < counter; i++)
            {
                n->remaining[i] = keywords[i]; // iterates through the remaining and keywords array
            }
            
            n -> engEquiv = storedProv; // gets the english equivalent and stores it
        }
        
        
        else if (hashTable[indx].next != NULL)
        {
            n = hashTable[indx].next;
            temp = n;
            
            if( n -> next != NULL)
            {
                while ( n -> next != NULL)
                {
                    n = n -> next;
                    temp = n;
                }
            }
            
            n = new node; // create a new node
            temp -> next = n; // set temps next pointer equal to that new node *temp is pointing to the intial node in this case*
            n -> hashWord = currentKey; // set the current word that is being hashed equal to hashword for that particular data
            
            getRemaining(); // removes the hash word from the other key words
            
            for (int i = 0; i < counter; i++)
            {
                n->remaining[i] = keywords[i]; // iterates through the remaining and keywords array
            }
            
            n -> engEquiv = storedProv; // gets the english equivalent and stores it
            
            
            
        }
        
        
    }
    
    
    
    void house::getRemaining()
    {
        stringstream eraser(phrase); // Insert the proverb into a stream
        
        i = 0;
        counter = 0;
        
        while (eraser >> filter) // while not at end of phrase get remaining
        {
            if(filter == currentKey) // if the current word that is being iterated is the current keyword then:
            {
                eraser >> filter;    // iterate over that word
            }
            keywords[i] = filter; // put the other keywords into an array
            counter++; // count remaining
            i++;
        }
        
    }
    
    
    void::house::storeStopWords()
    {
        stopWords.open("/Users/tenealaspencer/Library/Developer/Xcode/DerivedData/trans3-hhytnqxxkhrrlvajlsbdnxevlrug/Build/Products/Debug-iphonesimulator/stopwords.txt"); // open the stop words text file
        
        while(stopWords) // while not at the end of file
        {
            getline(stopWords, word); // get each thingy line by line
            
            
            hashS = 0;
            
            for (int i = 0; i < word.length(); i++)
                
            {
                
                hashS = (hashS << 4) + (int)word[i]; // compute a hash value the same way you would compute a hash value if it is in the table
                
            }
            
            indx = hashS;
            indx = abs(indx % size); // modules by table size
            stopwords [indx] = word;
            
        }
    }
    
    
    
    house::house()
    {
        
    }
    
    house::~house()
    {
        
    }
    
#ifdef _cplusplus
}

#endif
