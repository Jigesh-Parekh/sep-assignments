//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//Quick Sort

var randomNumbers = [42, 12, 88, 62, 63, 56, 1, 77, 88, 97, 97, 20, 45, 91, 62, 2, 15, 31, 59, 5]
func partition(arr: inout [Int], left: Int, right: Int) -> Int {
    //var v = arr
    var i = left
    for j in (left + 1)...(right) {
        if arr[j] < arr[left] {
            i += 1
            //swap
            (arr[i], arr[j]) = (arr[j], arr[i])
        }
    }
    (arr[i], arr[left]) = (arr[left], arr[i])

    return i
}

func quicksort(v: inout [Int], left: Int, right: Int) {
    if right > left {
        let pivotIndex = partition(arr: &v, left: left, right: right)
        quicksort(v: &v, left: left, right: pivotIndex - 1)
        quicksort(v: &v, left: pivotIndex + 1, right: right)
    }
    
    //print(v)
}
print(randomNumbers.count)

quicksort(v: &randomNumbers, left: 0, right: randomNumbers.count - 1)

//-------------------------------------------------------------------------
//Heap Sort

var array = [22,12,11,14,41,51,15,82,55]

func iParent(pos: Int) -> Double {
    var parent: Double
    parent = floor((Double(pos) - 1) / 2)
    return parent
}

func iLeftChild(pos: Int) -> Int {
    var leftChild: Int
    leftChild = (2 * pos) + 1
    return leftChild
}

func iRightChild(pos: Int) -> Int {
    var rightChild: Int
    rightChild = (2 * pos) + 2
    return rightChild
}

func heapify(arr: inout [Int]) {
    let count = arr.count
    let end = count - 1
    var start = iParent(pos: end)
    
    while start >=  0 {
        //(arr[0], arr[end]) = (arr[end], arr[0])
        //end = end - 1
        siftDown(arr: &arr, initPos: Int(start), endPos: end)
        start = start - 1
    }
}

func siftDown(arr: inout [Int], initPos: Int, endPos: Int) {
    var root = initPos
    
    while iLeftChild(pos: root) <= endPos {
        let child = iLeftChild(pos: root)
        var swap = root
        
        if arr[swap] < arr[child] {
            swap = child
        }
        if child + 1 <= endPos && arr[swap] < arr[child+1] {
            swap = child + 1
        }
        if swap == root {
            return
        } else {
            (arr[root], arr[swap]) = (arr[swap], arr[root])
            root = swap
        }
    }
    
}
var argg = [23,1,6,19,14,18,8,24,15]

print(argg)
heapify(arr: &argg)

// Bucket Sort -----------------------------------------------

//func insertionSort(array: inout [Int]) -> [Int] {
//
//    for firstNumToCompare in 1...array.count-1 {
//        let currVal = array[firstNumToCompare]
//        var prevPos = firstNumToCompare - 1
//        while (prevPos >= 0 && array[prevPos] > currVal) {
//            array.swapAt(prevPos+1, prevPos)
//            prevPos -= 1
//        }
//    }
//    return array
//}

extension Int: IntConvertible, Sortable {
    public func toInt() -> Int {
        return self
    }
}

fileprivate func >= <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l >= r
    default:
        return !(lhs < rhs)
    }
}

fileprivate func < <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

public struct Bucket<T:Sortable> {
    var elements: [T]
    let capacity: Int
    
    public init(capacity: Int) {
        self.capacity = capacity
        elements = [T]()
    }
    
    public mutating func add(item: T) {
        if (elements.count < capacity) {
            elements.append(item)
        }
    }
    
    public func sort(algo: Sorter) -> [T] {
        return algo.sort(items: elements)
    }
}

public protocol Sortable: IntConvertible, Comparable {
}
//map generic elements to Int
public protocol IntConvertible {
    func toInt() -> Int
}
public protocol Sorter {
    func sort<T:Sortable>(items: [T]) -> [T]
}
public protocol Distributor {
    func distribute<T>(element: T, buckets: inout [Bucket<T>])
}
//check if numbers are non negative
private func allPositiveNumbers<T: Sortable>(_ array: [T]) -> Bool {
    return array.filter { $0.toInt() >= 0 }.count > 0
}

private func enoughSpaceInBuckets<T>(_ buckets: [Bucket<T>], elements: [T]) -> Bool {
    let maximumValue = elements.max()?.toInt()
    let totalCapacity = buckets.count * (buckets.first?.capacity)!
    
    return totalCapacity >= maximumValue
}

//custom sorter - instertion sort
public struct InsertionSort: Sorter {
    public func sort<T>(items: [T]) -> [T] where T : Sortable {
        var results = items
        for i in 0 ..< results.count{
            var j = i
            while( j > 0 && results[j - 1] > results[j]) {
                //sort
                let aux = results[j-1]
                results[j-1] = results[j]
                results[j] = aux
                j -= 1
            }
        }
        return results
    }
}

//custom distributor split in buckets of 10
public struct RangeDistribute: Distributor {
    public func distribute<T>(element: T, buckets: inout [Bucket<T>]) where T : Sortable {
        let value = element.toInt()
        let bucketCapacity = buckets.first!.capacity
        
        let bucketIndex = value / bucketCapacity
        buckets[bucketIndex].add(item: element)
    }
}

func bucketSort<T:Sortable>(elements: [T], distributor: Distributor, sorter: Sorter, buckets: [Bucket<T>]) -> [T] {
    precondition(allPositiveNumbers(elements))
    precondition(enoughSpaceInBuckets(buckets, elements: elements))

    var bucketsCopy = buckets
    for elem in elements {
        distributor.distribute(element: elem, buckets: &bucketsCopy)
    }
    
    var results = [T]()
    
    for bucket in bucketsCopy {
        results +=  bucket.sort(algo: sorter)
    }
    
    return results
}

var arg3 = [23,1,6,19,14,18,8,24,15]
var buckets = [Bucket<Int>(capacity: 10), Bucket<Int>(capacity: 10), Bucket<Int>(capacity: 10)]

bucketSort(elements: arg3, distributor: RangeDistribute(), sorter: InsertionSort(), buckets: buckets)



































