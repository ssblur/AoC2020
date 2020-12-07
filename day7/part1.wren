/// 
//  Advent of Code 2020 Day 5 Part 2
//  All these bags and positively no shoes! The horror!
//  @author Patrick Emery

import "io" for File
var input = File.read("input.txt").trim().split("\r\n")

var rules = {}
input.each{|line|
    line = line.split("s contain ")
    var type = line[0]

    var contents = {}
    line = line[1].split(", ")
    line.each{|bag|
        if(bag.trim() != "no other bags.") {
            bag = bag.trim().split(" ")
            contents[bag[1..bag.count - 1].join(" ").trimEnd("s.")] = Num.fromString(bag[0])
        }
    }

    rules[type] = contents
}

var bagToFind = "shiny gold bag"
var bagsToFlag = {}
rules.keys.each{|k|
    if(k!=bagToFind && rules[k][bagToFind] && rules[k][bagToFind]>0){
        bagsToFlag[k] = "%(k) contains %(bagToFind)"
    }
}

for(i in 0..rules.count){ // Worst case: every single bag contains one other bag, and no two bags have the same contents.
    rules.each{|rule|
        var k = rule.key
        var v = rule.value
        v.keys.each{|bag|
            if(bag==bagToFind && rules[k][bagToFind]>0){
                bagsToFlag[k] = "%(k) contains %(bagToFind)"
            } else if(bagsToFlag[bag] && rules[k][bag]>0) {
                bagsToFlag[k] = "%(k) contains %(bagsToFlag[bag])"
            }
        }
    }
}
System.print("\n%(bagsToFlag.count) bags will eventually contain a %(bagToFind).")