#include "doctest.h"

TEST_CASE("test true")
{
    CHECK(true);
    SUBCASE("Not false") {
        CHECK(!false);
    }
}
