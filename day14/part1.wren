/// 
//  Advent of Code 2020 Day 14 Part 1
//  You'd think they'd have thought to check if these were compatible.
//  Unprepared, smh
//  @author Patrick Emery

import "io" for File, Stdin
var input = File.read("input.txt").trim().split("\r\n").map{|line| line.split(" = ")}

var mask = ""
var memory = {}
input.each{|line|
    if(line[0]=="mask"){
        mask = line[1]
    } else if(line[0][0..2] == "mem"){
        var i = Num.fromString(line[0][4..-2])
        var v = Num.fromString(line[1])
        var v32 = v % (2.pow(32)) // Bitwise operations cast numbers to 32 bit integers
        var v4 = (v / (2.pow(32))).floor

        System.print("%(v32), %(v4)")
        (0...mask.count).each{|i|
            var c = mask[i]
            if(i<=3){
                if(c == "1"){
                    v4 = v4 | (2.pow(3-i))
                } else if(c == "0") {
                    v4 = v4 & (~(2.pow(3-i)))
                }
            } else {
                if(c == "1"){
                    v32 = v32 | (2.pow(35-i))
                } else if(c == "0") {
                    v32 = v32 & (~(2.pow(35-i)))
                }
            }
        }
        System.print("%(v32), %(v4)")
        v = v32 + (v4 * (2.pow(32)))

        memory[i] = v
        System.print("mem[%(i)]: %(line[1]) -> %(v)")
    }
}

var total = 0
memory.each{|v| 
    total = total + v.value
}
System.print("Total: %(total)")