/// 
//  Advent of Code 2020 Day 10 Part 1
//  Writing a quick quicksort implementation since List.sort doesn't seem to be supported in this version.
//  Thanks Nico.
//  Still watching Who's Line though.
//  @author Patrick Emery

import "io" for File
var input = File.read("input.txt").trim().split("\r\n").map{|line| Num.fromString(line)}.toList


var helper
var partition
helper = Fn.new { |list, min, max| // I don't love side effects but swapping list elements is better than creating dozens of lists.
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

var differences = {
    0: 0,
    1: 0,
    2: 0,
    3: 0
}

for(i in 0..input.count-2){
    var d = input[i+1] - input[i]
    differences[d] = differences[d] + 1
}
differences[3] = differences[3] + 1

System.print("Your chargers have the following joltage differences (joltage difference -> amount):")
differences.each{ |item|
    System.print("\t%(item.key) -> %(item.value)")
}

var x = differences[1]
var y = differences[3]
System.print("\n%(x) * %(y) = %(x*y)")