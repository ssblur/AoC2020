/// 
//  Advent of Code 2020 Day 5 Part 2
//  With my luck, I have a middle seat...
//  @author Patrick Emery

import "io" for File
var input = File.read("input.txt").trim().split("\r\n")

var occupied = {}

input.each{|seat|
    var rma = 127
    var rmi = 0
    var cma = 7
    var cmi = 0
    seat.each{|char|
        if(char=="F") {
            var r = rma - rmi
            rma = rmi + (r/2).floor
        } else if(char=="B") {
            var r = rma - rmi
            rmi = rmi + (r/2).ceil
        } else if(char=="L") {
            var r = cma - cmi
            cma = cmi + (r/2).floor
        } else if(char=="R") {
            var r = cma - cmi
            cmi = cmi + (r/2).ceil
        }
    }
    var id = rma * 8 + cma
    System.print("Seat: %(rma), %(cma) (ID: %(id))")

    occupied[id] = true
}

occupied.keys.each{|k|
    if(occupied[k+2] && !occupied[k+1]){
        var middleSeat = [1,2,4,5].contains((k+1)%8)
        System.print("\nSeat with ID %(k+1) is available. (It is %(middleSeat ? "" : "not ")a middle seat)") // Holy cow it's not a middle seat.
    }
}