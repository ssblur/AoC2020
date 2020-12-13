/// 
//  Advent of Code 2020 Day 2 Part 1
//  Passwords this time, should be fun.
//  @author Patrick Emery

import "io" for File
var input = File.read("input.txt").trim().split("\n")
var valid = 0

input.each { |password|
    var min = password.split("-")
    password = min[1]
    min = Num.fromString(min[0])
    var max = password.split(" ")
    password = max[1..2].join(" ")
    max = Num.fromString(max[0])
    var char = password.split(":")
    password = char[1].trim()
    char = char[0]

    var appearances = 0
    password.each{|c| 
        if(c == char) appearances = appearances + 1
    }

    if(appearances<=max && appearances>=min) valid = valid + 1
}

System.print(valid)