/// 
//  Advent of Code 2020 Day 14 Part 1
//  This is a weird game.
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

while(turn < 2020){
    var ln = number
    number = turn - (turns[number] || turn)
    System.print("%(number) - Turn %(turn+1) (%(ln) was "+(turns[ln] ? "last seen on turn %(turns[ln]))" : "never seen.)"))
    turns[ln] = turn
    turn = turn + 1
}