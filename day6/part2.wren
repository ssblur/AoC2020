/// 
//  Advent of Code 2020 Day 5 Part 2
//  I had not anticipated this.
//  @author Patrick Emery

import "io" for File
var input = File.read("input.txt").trim().split("\r\n\r\n")

var groups = []
input.each{|group| 
    var passengers = group.split("\r\n").map{|line| line.trim()}.toList
    var yes = {}
    passengers[0].each{|char| yes[char] = true}
    yes = yes.keys.where{|char|
        var valid = true
        passengers.each{|passenger|
            valid = valid && passenger.indexOf(char)!=-1
        }
        return valid
    }.toList
    groups.add(yes)
    System.print("%(yes.count) questions were answered yes in this group.")
}

var sum = 0
groups.each{|yes| sum = sum + yes.count}
System.print("%(sum) questions were answered yes between groups.")