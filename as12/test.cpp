#include <iostream>

bool isPrime(int n){
    if(n <= 1)
        return false;

    for(int i = 2; i <= n/2; i++){
        if(n % i == 0)
            return false;
    }

    return true;
}

int main(){

    if(isPrime(2) == true)
        std::cout << "2 is prime" << std::endl;

    

    return 0;
}