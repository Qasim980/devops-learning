#!/bin/bash

read -p "Enter first number: " num1
read -p "Enter second number: " num2

# Read command fulfils requirement of taking user input

echo $((num1 + num2))
echo $((num1 - num2))
echo $((num1 * num2))
echo $((num1 / num2))

# All four arithmetic operations are performed using the arithmetic expansion $((...))
# Results are displayed using echo command