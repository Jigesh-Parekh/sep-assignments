//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var array = [1,2,4,8,16,32,64,128,256,512,1024]

array.map{ $0 }


/*
 
 1.Describe an analogy for relating an algorithm that has efficiency O(1) and another algorithm that has O(2n).
 O{1) - a bullet has a constant velocity as time increases no matter how long the bullet travels for... it will continue on its path with the same speed and effficiency as it did leaving the chamber
 O(2^n) - a bullet has an ecponentially slower velocity as time increases... the bullet is shot inside a vat of special Jel... as it traverses the jelly n meters it takes 2^n amount of time to go the same distance further)
 
 2.In plain English, what is the best case scenario for binary search?
 Binary search best case scenario is O(1) meaning in plain english that no matter how long a list of people there are in a line, It takes me the same amount of time (for arguments sake... one second) to find anyone in that line starting at one end)
 
3.In plain English, what is the worst case scenario for binary search?
 Binary search worst case time complexity is O(n) in plain engligh means that the worst case of me finding someone in a line of people will at most the count of amount of people in that line... so worst case I will be searching for the last person in the line of people, and I hace to check every one until I get there, there are 600 people so it would take an equal 600 seconds to find that last person.
 
 4.In plain English, what is the bounded-case scenario for binary search?
    O(log n) the time it takes to find a person of interest is a log factor faster per person checked
 
 5. graphed above
 
 6. as n -> inf  n^2
 7. O(n^2)
 
 9 10 and 11 are rehased questions that do not warrent a response.
 */
