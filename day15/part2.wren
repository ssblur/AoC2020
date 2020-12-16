/// 
//  Advent of Code 2020 Day 14 Part 1
//  This is the easiest part 2 known to man.
//  @author Patrick Emery

import "io" for File, Stdin
var input = File.read("input.txt").trim().split(",").map{|line| Num.fromString(line)}.toList

var turn = 1
var number = 0
var turns = {}

input[0...(input.count-1)].each{|n|
    number = n
    turns[number] = turn
    turn = turn + 1
}
number = input[-1]

while(turn < 30000000){
    var ln = number
    number = turn - (turns[number] || turn)
    turns[ln] = turn
    turn = turn + 1
}

System.print("The 30000000th number is %(number)")