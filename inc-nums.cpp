/*
 * inc-nums.cpp
 * Copyright (C) 2019 Shlomi Fish <shlomif@cpan.org>
 *
 * Distributed under terms of the MIT license.
 */

#include <fstream>

int main(int, const char *argv[])
{
    std::ifstream f(argv[1], std::ios::in);
    std::string l;
    unsigned long long last = 0;
    while (getline(f, l))
    {
        const size_t idx = l.find_last_not_of("0123456789");
        const unsigned long long n = std::stoull(l.substr(idx + 1));
        if (last >= n)
        {
            return -1;
        }
        last = n;
    }
    return 0;
}
