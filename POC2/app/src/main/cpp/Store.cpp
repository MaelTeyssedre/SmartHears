//
// Created by MT on 4/9/2022.
//

#include "Store.h"
#include <jni.h>
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

extern "C"
JNIEXPORT jint
JNICALL
Java_com_smarthears_poc2_MainActivity_cppFunction(
        JNIEnv *env,
        jobject thiz,
        jint nb) {
    int test = (int) nb;
    Store store = Store();
    store.setInteger(test);
    store.compute();
    return store.getCount();
}