/// 
//  Advent of Code 2020 Day 5 Part 2
//  I've got baaaaaags, they're multiplyin'!
//  And I'm loooooosin' contro-ol.
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

var expand
expand = Fn.new{ |bagName, quantity, depth|
    if(depth==0){
        System.print("%(quantity) %(bagName)")
    }
    var bag = rules[bagName]
    var contents = {}
    bag.keys.each{ |key|
        (0..depth).each{|i| System.write("\t")}
        System.print("%(bag[key]*quantity) %(key)")
        contents[key] = (contents[key] || 0) + bag[key] * quantity
        if(rules[key]) {
            if(rules[key].count>0){
                var c = expand.call(key, bag[key] * quantity, depth + 1)
                c.keys.each{ |ck|
                    contents[ck] = (contents[ck] || 0) + c[ck]
                }
            }
        }
    }
    return contents
}

var sum = 0
expand.call("shiny gold bag", 1, 0).values.each{|v|
    sum = sum + v
}
System.print(sum)