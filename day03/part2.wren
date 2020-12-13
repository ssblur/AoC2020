/// 
//  Advent of Code 2020 Day 3 Part 2
//  Toboggan Time, baby
//  @author Patrick Emery

import "io" for File
var input = File.read("input.txt").trim().split("\n")

var slopes = [
    [1, 1],
    [3, 1],
    [5, 1],
    [7, 1], 
    [1, 2]
]

var trees = 1
slopes.each{ |slope|
    var xo = slope[0]
    var yo = slope[1]
    var x = 0
    var y = 0
    var t = 0
    while(y < input.count){
        var line = input[y].trim()
        var i = x%(line.count)
        if(line[i] == "#") {
            t = t + 1
        }
        x = x + xo
        y = y + yo
    }   
    System.print("%(t) Trees on slope %(slope)")
    trees = trees * t
}

System.print("%(trees) Trees")