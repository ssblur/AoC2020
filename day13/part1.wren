/// 
//  Advent of Code 2020 Day 13 Part 1
//  Shuttle Time Woo
//  @author Patrick Emery

import "io" for File
var input = File.read("input.txt").trim().split("\r\n")
var earliest = Num.fromString(input[0].trim())
var buses = input[1].split(",").where{|bus| bus.trim() != "x" }.map{|bus|
    return Num.fromString(bus.trim())
}

var soonest
var soonestBus
buses.each{|bus|
    var time = ((earliest/bus).ceil) * bus
    System.print("Can embark on bus %(bus) after %(earliest) at earliest %(time).")
    if(soonest==null || time<soonest){
        soonest = time
        soonestBus = bus
    }
}

System.print("%(soonest) is the soonest you can embark on bus %(soonestBus).")
System.print("Composite %((soonest - earliest) * soonestBus)")