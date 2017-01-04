#include <iostream>
#include <vector>
#include <fstream>
#include <string>
#include <cstdlib>

using namespace std;

class Character
{
    
public:
    vector <int> set;
    
    Character(int a, int b, int c, int d, int e)
    {
        set.push_back(a);
        set.push_back(b);
        set.push_back(c);
        set.push_back(d);
        set.push_back(e);
    }
    
    bool operator== (const Character &right)
    {
            if(set[0] != right.set[0])
            {
                for(int j = 1; j < set.size(); ++j)
                {
                    if(set[j] == right.set[j])
                    {
                        return false;
                    }
                }
            }
        
        if(set[0] == right.set[0])
        {
            for(int j = 1; j < set.size(); ++j)
            {
                if(set[j] != right.set[j])
                {
                    return false;
                }
            }
        }
        
        return true;
    }

};


int main ()
{
    int charactersUnsplit[5][100];
    vector<int> letter;
    string line;
    int letters, num;
    
    fstream trees("sequences01.txt", ios:: in | ios::out);
    
    
    trees >> line;
    
    letters = line[0] - 48;
    
    trees >> line;
    
    for(int j = 0; j < letters; ++j)
    {
    
    trees >> line;
    trees >> line;
    
    for(int i = 0; i < line.length();++i)
    {
        num = line[i] - 48;
        charactersUnsplit[j][i] = num;
    }
        
    }
    
    
    vector<Character*> characters;
    Character* chara;
    
    for(int i = 0; i < line.length(); ++i)
    {
        chara = new Character(charactersUnsplit[0][i], charactersUnsplit[1][i], charactersUnsplit[2][i], charactersUnsplit[3][i], charactersUnsplit[4][i]);
        
        characters.push_back(chara);
    }
    
    
    
    
    
    
    
    
    
    
    
    for(int i = 0; i < line.length(); ++i)
    {
        delete [] characters[i];
    }
    characters.clear();
}


