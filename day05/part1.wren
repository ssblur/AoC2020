/// 
//  Advent of Code 2020 Day 5 Part 1
//  Can you imagine riding a plane?
//  I'll just toboggan the whole way.
//  @author Patrick Emery

import "io" for File
var input = File.read("input.txt").trim().split("\r\n")

var highestID = 0

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
    highestID = highestID > id ? highestID : id // id.max(highestID) wasn't working as expected. Will review this later
}

System.print("Highest ID: %(highestID)")