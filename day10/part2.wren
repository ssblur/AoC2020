/// 
//  Advent of Code 2020 Day 10 Part 2
//  I got distracted watching outtakes on YouTube, whoops
//  @author Patrick Emery

import "io" for File
var input = File.read("input.txt").trim().split("\r\n").map{|line| Num.fromString(line)}.toList


var helper
var partition
helper = Fn.new { |list, min, max|
    if(min<max){
        var pivot = partition.call(list, min, max)
        helper.call(list, min, pivot - 1)
        helper.call(list, pivot + 1, max)
    }
    return list
}
partition = Fn.new{ |list, min, max|
    var pivot = list[max]
    var x = min
    for(i in min..max){
        if(list[i] < pivot){
            var a = list[x]
            list[x] = list[i]
            list[i] = a
            x = x + 1
        }
    }
    var a = list[x]
    list[x] = list[max]
    list[max] = a
    return x
}
var quicksort = Fn.new {|list| helper.call(list, 0, list.count - 1)}

input.add(0)
quicksort.call(input)
input.add(input[-1]+3)

var arrangements
var cache = {} //   Very dynamic lol
arrangements = Fn.new { |list, index|
    if(cache.containsKey(index)) return cache[index]
    if(index==0) return 1
    var total = 0
    (0...index).each{|i|
        if((list[index]-list[i])<=3) total = total + arrangements.call(list, i)
    }
    cache[index] = total
    return total
}
System.print(arrangements.call(input, input.count-1))