/// 
//  Advent of Code 2020 Day 11 Part 2
//  Now with Ray Tracing!
//  @author Patrick Emery

import "io" for File
var input = File.read("input.txt").trim().split("\r\n").map{|line| // I wanted to do this mostly for some potential shortcuts moving forward.
    return line.map{|char|
        if(char=="L") return 0
        if(char=="#") return 1
        if(char==".") return -1
    }.toList
}.toList

var min = Fn.new { |a, b| a>b ? b : a }
var max = Fn.new { |a, b| a>b ? a : b }

var checkInDirection = Fn.new{|board, r, c, ox, oy|
    var x = r + ox
    var y = c + oy
    var w = board[0].count
    while(x>=0 && x<board.count && y>=0 && y<w){
        if(board[x][y]>=0){
            return board[x][y]
        }
        x = x + ox
        y = y + oy
    }
    return 0
}

var surrounded = Fn.new{|board, r, c|
    var total = 0
    for(x in -1..1){
        for(y in -1..1){
            if(x!=0 || y!=0) total = total + checkInDirection.call(board, r, c, x, y)
        }
    }
    return total
}

var map = { // I prefer the happy faces to the L's, #'s, and .'s of the original.
    -1: " ",
    0: "O",
    1: "☺",
}
var printBoard = Fn.new{|board|
    for(x in 0..board[0].count) System.write("-")
    System.print("-")
    board.each{|row|
        System.write("|")
        row.each{|slot|
            System.write(map[slot])
        }
        System.print("|")
    }
    for(x in 0..board[0].count) System.write("-")
    System.print("-")
}

var compareBoards = Fn.new{|a, b|       // List comparison don't work based on content. I don't love this, but I'm tired.
    a = a.map{|l| l.join("")}.join("\n")
    b = b.map{|l| l.join("")}.join("\n")
    return a==b
}

var game = Fn.new{|board|
    var last = board    // Keep a history
    var new = []
    while(true){
        printBoard.call(last)   // This is basic visualization. Comment out if the script takes more than a moment.
        for(r in 0..last.count-1){
            var row = last[r]
            new.add([])
            for(c in 0..row.count-1){
                var pos = row[c]
                if(pos>=0){
                    if(pos==0 && surrounded.call(last, r, c)==0){
                        new[-1].add(1)
                    } else if(pos==1 && surrounded.call(last, r, c)>=5) {
                        new[-1].add(0)
                    } else {
                        new[-1].add(pos)
                    }
                } else {
                    new[-1].add(-1)
                }
            }
        }
        if(compareBoards.call(last, new)){
            var total = 0
            last.each{|row|
                row.each{|i|
                    if(i==1) total = total + 1
                }
            }
            return total 
        }
        last = new
        new = []
    }
}

System.print(game.call(input))