/*
 * inc-nums.cpp
 * Copyright (C) 2019 Shlomi Fish <shlomif@cpan.org>
 *
 * Distributed under terms of the MIT license.
 */

#include <fstream>
#include <iostream>
#include <string>

int main(int, const char *argv[])
{
    std::ifstream f(argv[1], std::ios::in);
    std::string l;
    unsigned long long S = 0, I = 0;
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
    std::cout << "S\t" << S << std::endl << "Int\t" << I << std::endl;
    return 0;
}
