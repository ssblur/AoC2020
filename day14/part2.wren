/// 
//  Advent of Code 2020 Day 14 Part 1
//  Why can't bitwise operators on integers be 1024 bits?
//  The price I pay for using a novel language.
//  @author Patrick Emery

import "io" for File, Stdin
var input = File.read("input.txt").trim().split("\r\n").map{|line| line.split(" = ")}

var mask = ""
var memory = {}

var transform = Fn.new { |v|
    var v32 = [v % (2.pow(32))] // Bitwise operations cast numbers to 32 bit integers
    var v4 = [(v / (2.pow(32))).floor]
    (0...mask.count).each{|i|
        var c = mask[i]
        if(i<=3){
            if(c == "1"){
                var n = []
                v4.each{|x| 
                    n.add(x | (2.pow(3-i)))
                }
                v4 = n
            } else if(c == "X") {
                var n = []
                v4.each{|x|
                    n.add(x | (2.pow(3-i)))
                    n.add(x & (~(2.pow(3-i))))
                }
                v4 = n
            }
        } else {
            if(c == "1"){
                var n = []
                v32.each{|x| 
                    n.add(x | (2.pow(35-i)))
                }
                v32 = n
            } else if(c == "X") {
                var n = []
                v32.each{|x|
                    n.add(x | (2.pow(35-i)))
                    n.add(x & (~(2.pow(35-i))))
                }
                v32 = n
            }
        }
    }

    var out = []
    v4.each{|x|
        v32.each{|y|
            out.add(y + (x * (2.pow(32))))
        }
    }
    return out
}

input.each{|line|
    if(line[0]=="mask"){
        mask = line[1]
    } else if(line[0][0..2] == "mem"){
        var i = transform.call(Num.fromString(line[0][4..-2]))
        var v = Num.fromString(line[1])

        i.each{|x|
            memory[x] = v
        }
    }
}

var total = 0
memory.each{|v| 
    total = total + v.value
}
System.print("Total: %(total)")