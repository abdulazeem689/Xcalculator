//
//  CppCode.cpp
//  Xcalculator
//
//  Created by Abdul Azeem on 28/08/20.
//  Copyright © 2020 Mindfire. All rights reserved.
//

#include "CppCode.hpp"
#include <iostream>
#include <stack>
using namespace std;

int precedence(char op){
    if(op == '+' || op == '-') return 1;
    if(op == 'x' || op == '/') return 2;
    return 0;
}

double oneOperation(double operand1, double operand2, char op){
    switch (op) {
        case '+':
            return operand1 + operand2;
        case '-':
            return operand1 - operand2;
        case 'x':
            return operand1 * operand2;
        case '/':
            return operand1 / operand2;
        default:
            return 0;
    }
}

double CppClass::evaluate(string expression){
    stack <double> operands;
    stack <char> operators;
    for(int i=0;i<expression.length();i++){
        if(isdigit(expression[i])){
            double val = 0;
            while(i<expression.length() && isdigit(expression[i])){
                val = val*10 + expression[i]-'0';
                i++;
            }
            if(expression[i] == '.'){
                i++;
                double j = 10;
                while(i<expression.length() && isdigit(expression[i])){
                    val += double(expression[i]-'0')/j;
                    j*=10.0;
                    i++;
                }
            }
            operands.push(val);
            i--;
        }
        else{
            while(!operators.empty() && precedence(operators.top()) >= precedence(expression[i])){
                double operand2 = operands.top();
                operands.pop();
                double operand1 = operands.top();
                operands.pop();
                char op = operators.top();
                operators.pop();
                operands.push(oneOperation(operand1, operand2, op));
            }
            operators.push(expression[i]);
        }
    }
    while(!operators.empty()){
        double operand2 = operands.top();
        operands.pop();
        double operand1 = operands.top();
        operands.pop();
        char op = operators.top();
        operators.pop();
        operands.push(oneOperation(operand1, operand2, op));
    }
    return operands.top();
}
