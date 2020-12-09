/// 
//  Advent of Code 2020 Day 9 Part 2
//  Who needs efficiency when you have time?
//  @author Patrick Emery

import "io" for File
var input = File.read("input.txt").trim().split("\r\n").map{|line| Num.fromString(line)}.toList

var preambleLength = 25

var invalid = false
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
        invalid = input[i]
        break
    }
}

for(i in 0..input.count-2){
    for(j in i+1..input.count-1){
        var sum = 0
        for(x in input[i..j]){
            sum = sum + x
        }
        if(sum == invalid){
            var range = input[i..j]
            System.print("The following range contains the weakness: %(range)")
            var min = false
            var max = false
            for(x in range){
                if(min==false || x<min) min = x
                if(max==false || x>max) max = x
            }

            System.print("The weakness is %(min+max)")
            Fiber.suspend()
        }
    }
}