/// 
//  Advent of Code 2020 Day 2 Part 2
//  Passwords this time, should be fun.
//  @author Patrick Emery

import "io" for File
var input = File.read("input.txt").trim().split("\n")
var valid = 0

input.each { |input|
    var x = input.split("-")
    var password = x[1]
    x = Num.fromString(x[0]) - 1
    var y = password.split(" ")
    password = y[1..2].join(" ")
    y = Num.fromString(y[0]) - 1
    var char = password.split(":")
    password = char[1].trim()
    char = char[0]

    System.print("'%(password)': %(password[x]), %(password[y]) \n\t(%(input.trim()))") // Debug print, left for posterity.

    valid = valid + ((password[x]==char) != (password[y]==char) ? 1 : 0)
}

System.print(valid)