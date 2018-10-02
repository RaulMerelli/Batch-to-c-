#include <iostream>
#include <stdlib.h>
#include <sstream>

using namespace std;

string IntToString (int a)
{
    ostringstream temp;
    temp<<a;
    return temp.str();
}

int StringToInt (string a)
{
    return atoi(a.c_str());
}

int main()
{
    string test;
    int test_temp;

    cout<<"Inserisci numero: ";
    getline(cin,test);
    cout<<test<<endl;

    test_temp=StringToInt(test)+1;

    test=IntToString(test_temp);

    cout<<test<<endl;

    return 0;
}


//gestione variabili batch:
//tutto è string e all'occorrenza
//tutto può diventare int
