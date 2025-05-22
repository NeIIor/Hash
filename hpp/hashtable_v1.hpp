// hpp/hashtable_v1.hpp
#ifndef HASHTABLE_V1_HPP
#define HASHTABLE_V1_HPP

#include <cstdint>
#include <cstddef>

typedef struct bucket {
    char name[64];
    struct bucket* next;
} bucket_t;

typedef struct hashTbl {
    bucket_t** buckets;
    int num_bckts;
} hashTbl_t;

enum exits{

    OK  = 0,
    ERR = 1,

};

const int NUM_BCKT = 1409;
const int MAX_NAME = 64;
const int TEST_ITER = 5000;
const int TIME_SCALE = 2400000000; // ~2.4 GHz

int hashTblCtor(hashTbl_t** hashtbl);
int hashTblDtor(hashTbl_t* hashtbl);
int hashTblAdd(hashTbl_t* hashtbl, char* name);
int hashTblFind(hashTbl_t* hashtbl, char* name);
int hashTblDump(hashTbl_t* hashtbl);
int textParse(hashTbl_t* hashtbl, const char* file);
double doTest(hashTbl_t* hashtbl, const char* filename);

#endif



