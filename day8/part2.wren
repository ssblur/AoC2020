/// 
//  Advent of Code 2020 Day 5 Part 2
//  Branches? Recursion?!? This feels like Lisp.
//  Very functional
//  @author Patrick Emery

import "io" for File
var input = File.read("input.txt").trim().split("\r\n")

var next
next = Fn.new{ |line, accumulator, traversed, input, changed|
    if(traversed.any{|item| item==line}){ 
        System.print("Halting to prevent loop at %(line)")
        return false 
    }
    if(line>=input.count){ 
        System.print("Reached end of program at %(line)")
        return accumulator 
    }

    var instruction = input[line].trim().split(" ")
    var parameter = Num.fromString(instruction[1])
    instruction = instruction[0]
    System.print("%(line): %(instruction) %(parameter) (changed %(changed))")
    if(instruction=="jmp" && changed!=line || instruction=="nop" && changed==line){
        traversed.add(line)
        var ret = next.call(line + parameter, accumulator, traversed.toList, input, changed)
        if(ret){ 
            return ret 
        }

        if(changed==false){
            return next.call(line + 1, accumulator, traversed.toList, input, line)
        }
    } else if(instruction=="nop" && changed!=line || instruction=="jmp" && changed==line){
        traversed.add(line)
        var ret = next.call(line + 1, accumulator, traversed.toList, input, changed)
        if(ret){ 
            return ret 
        }
        
        if(changed==false){
            return next.call(line + parameter, accumulator, traversed.toList, input, line)
        }
    } else if(instruction=="acc"){
        accumulator = accumulator + parameter
        traversed.add(line)
        return next.call(line + 1, accumulator, traversed.toList, input, changed)
    }
}

System.print(next.call(0, 0, [], input, false))