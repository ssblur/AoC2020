/// 
//  Advent of Code 2020 Day 3 Part 1
//  Toboggan Time, baby
//  @author Patrick Emery

import "io" for File
var input = File.read("input.txt").trim().split("\n")

var x = 0
var trees = 0

input.each { |line|
    line = line.trim()
    var i = x%(line.count)
    if(line[i] == "#") {
        trees = trees + 1
    }
    x = x + 3
}

System.print("%(trees) Trees")