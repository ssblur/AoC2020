/// 
//  Advent of Code 2020 Day 6 Part 1
//  My only language barrier is the one that keeps PHP out.
//  @author Patrick Emery

import "io" for File
var input = File.read("input.txt").trim().split("\r\n\r\n")

var groups = []
input.each{|group| 
    var passengers = group.split("\r\n").map{|line| line.trim()}
    var yes = {}
    passengers.each{|passenger|
        passenger.each{|char| yes[char] = true} // If it wasn't clear yesterday, I've been trying to build part 1 in anticipation of part 2.
    }
    groups.add(yes)
    System.print("%(yes.count) questions were answered yes in this group.")
}

var sum = 0
groups.each{|yes| sum = sum + yes.count}
System.print("%(sum) questions were answered yes between groups.")