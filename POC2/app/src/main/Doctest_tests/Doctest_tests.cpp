#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include "doctest.h"

#include "Store.h"

TEST_CASE("Check Store") {

    Store store;

    SUBCASE("getCount") {
        int count = store.getCount();
        CHECK(count == 1);
    }

    SUBCASE("setInteger") {
        store.setInteger(2);
        int count = store.getCount();
        CHECK(count == 2);
    }

    SUBCASE("compute") {
        store.setInteger(2);
        store.compute();
        int count = store.getCount();
        CHECK(count == 4);
    }
}