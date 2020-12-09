/// 
//  Advent of Code 2020 Day 9 Part 1
//  I'm watching Who's Line right now, I can't think of anything funnier than that.
//  @author Patrick Emery

import "io" for File
var input = File.read("input.txt").trim().split("\r\n").map{|line| Num.fromString(line)}.toList

var preambleLength = 25

for(i in preambleLength..input.count-1){
    var pass = false
    for(x in input[i-preambleLength..i]){
        for(y in input[i-preambleLength..i]){
            if(x!=y && x+y == input[i]){
                pass = true
                break
            }
        }
        if(pass) break
    }

    if(!pass){
        System.print("The number %(input[i]) (%(i)) is invalid.")
        Fiber.suspend()
    }
}