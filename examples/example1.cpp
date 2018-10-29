#include <iostream> 
#include <stdlib.h> 
#include <sstream> 
 
using namespace std; 
 
int main(){ 
 
ostringstream cmd; 
 
system ("title Example"); 
cout<<"This is an example"<<endl; 
system ("pause > nul"); 
cout<<"Inserisci un numero: "; 
cin>>input; 
input+=1; 
cout<<input<<endl; 
system ("pause > nul"); 
 
return 0;} 
