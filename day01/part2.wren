/// 
//  Advent of Code 2020 Day 1 Part 2
//  Still don't really need concurrency. 
//  A step beyond the last one, just add in another layer for the third layer.
//  Probably could have expanded this to any nth-dimensional matrix, but eh.
//  @author Patrick Emery
import "io" for File
var input = File.read("input.txt").trim().split("\n").map {|line| Num.fromString(line)}

input.each{|x|
    input.each{|y|
        input.each{|z|
            if(x+y+z == 2020) {
                System.print(x * y * z)
                Fiber.suspend()
            }
        }
    }
}