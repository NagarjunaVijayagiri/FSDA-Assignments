#!/usr/bin/env python
# coding: utf-8

# In[1]:


### 1. Write a Python program to print \"Hello Python\"?

print(r'\"Hello Python\"?')
# r'statement or Expression' returns the raw statement. It calls the obj.__repr() function in the back end
# which helps in ignoring the special meaning of the escape characters \n,\t,\" ....


# In[11]:


### 2. Write a Python program to do arithmetical operations addition and division.

value1 = int(input('Enter 1st Value: '))
value2 = int(input('Enter 2nd Value: '))

Sum = value1+value2
Division = value1/value2

print('Sum of Values: ',Sum)
print('Division of Values: ',Division)


# In[15]:


### 3. Write a Python program to find the area of a triangle?

base = float(input('Enter the base of Triangle in centimeters: '))
height = float(input('Enter the height of Triangle in centimeters: '))

Area_of_Triangle = (1/2)*(base*height)

print("Area of triangle for the given base * height is: {0} centimeter square".format(Area_of_Triangle))


# In[26]:


### 4. Write a Python program to swap two variables?

variable1 = 'Var1'
variable2 = 'Var2'

variable1,variable2=variable2,variable1

print('After Swapping the value of variables,\nVariable1 = {0} \nVariable2 = {1}'.format(variable1,variable2))


# In[33]:


### 5. Write a Python program to generate a random number?
import random

randomInteger = random.randint(1,50) 
print(randomInteger)

# Imported random module to use randint() method to generate random number between 1 to 50. 





