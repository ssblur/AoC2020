/// 
//  Advent of Code 2020 Day 1 Part 1
//  Giving Wren a try. Likely not using any concurrency / async for day 1.
//  @author Patrick Emery

import "io" for File
var input = File.read("input.txt").trim().split("\n").map {|line| Num.fromString(line)}

input.each{|x|
    input.each{|y|
        if(x+y == 2020) {
            System.print(x * y)
            Fiber.suspend()
        }
    }
}