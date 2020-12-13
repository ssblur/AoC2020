/// 
//  Advent of Code 2020 Day 13 Part 2
//  Man I'd love one gold coin.
//  @author Patrick Emery

import "io" for File
var input = File.read("input.txt").trim().split("\r\n")
var earliest = Num.fromString(input[0].trim())
var buses = input[1].split(",").map{|bus|
    return Num.fromString(bus.trim())
}.toList

// I feel boring for using CRT, but it works splendidly.
var n = (0...buses.count).map{|i| buses[i]!=null ? (buses[i]-(i%buses[i]))%buses[i] : null}.where{|b| b!=null}.toList // Wren's mod lets you go negative by default.
buses = buses.where{|b| b!=null}.toList
var m = 0
var s = 1
(0...n.count).each{|i|
    var x = buses[i]
    var y = n[i]
    while(m % x != y) {
        m = m + s
    }
    s = s * x
}

var str = ""
while(m>0){
    var a = m%10
    m = (m/10).floor
    str = "%(a)%(str)"
}
System.print(str)