/*
 * inc-nums.cpp
 * Copyright (C) 2019 Shlomi Fish <shlomif@cpan.org>
 *
 * Distributed under terms of the MIT license.
 */

#include <fstream>
#include <iostream>
#include <string>

int main(const int argc, const char *argv[])
{
    unsigned long long S = 0, I = 0;
    for (int fn_idx = 1; fn_idx < argc; fn_idx++)
    {
        std::ifstream f(argv[fn_idx], std::ios::in);
        std::string l;
        while (getline(f, l))
        {
            if (l[0] == 'S')
            {
                ++S;
            }
            else
            {
                ++I;
            }
        }
    }
    std::cout << "S\t" << S << std::endl << "Int\t" << I << std::endl;
    return 0;
}
