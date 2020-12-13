/// 
//  Advent of Code 2020 Day 8 Part 1
//  Boot Loops, even better with milk.
//  @author Patrick Emery

import "io" for File
var input = File.read("input.txt").trim().split("\r\n")

var accumulator = 0
var line = 0
var instructions = {
    "nop": Fn.new{|arg|},
    "acc": Fn.new{|arg| accumulator = accumulator + arg},
    "jmp": Fn.new{|arg| line = line + arg - 1}
}

var traversed = {}
while(input[line]) {
    if(traversed[line]){
        break
    }

    var instruction = input[line].trim().split(" ")
    instructions[instruction[0]].call(Num.fromString(instruction[1]))

    traversed[line] = true
    line = line + 1
}

System.print("Accumulator is %(accumulator) before first double call.")