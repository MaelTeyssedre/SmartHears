//
// Created by MT on 4/9/2022.
//

#ifndef POC2_STORE_H
#define POC2_STORE_H

#include <string>

class Store {
public:
    Store();
    int getCount();
    void setInteger(int pInt);
    void compute();

private:
    int _count;
};



#endif //POC2_STORE_H