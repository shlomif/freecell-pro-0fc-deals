/*
 * inc-nums.cpp
 * Copyright (C) 2019 Shlomi Fish <shlomif@cpan.org>
 *
 * Distributed under terms of the MIT license.
 */

#include <fstream>
#include <string>

int main(const int argc, const char *argv[])
{
    unsigned long long last = 0;
    for (int fn_idx = 1; fn_idx < argc; fn_idx++)
    {
        std::ifstream f(argv[fn_idx], std::ios::in);
        std::string l;
        while (getline(f, l))
        {
            const unsigned long long n =
                std::stoull(l.substr(l.find('\t') + 1));
            if (last >= n)
            {
                return -1;
            }
            last = n;
        }
    }
    return 0;
}
