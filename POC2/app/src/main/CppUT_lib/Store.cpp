//
// Created by MT on 4/9/2022.
//

#include "Store.h"
#include <iostream>

Store::Store() : _count(1) {}

int Store::getCount() {
    return _count;
}

void Store::setInteger(int pInt) {
    _count = pInt;
}

void Store::compute() {
    _count *= _count;
}
