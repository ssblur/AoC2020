/// 
//  Advent of Code 2020 Day 10 Part 1
//  Conway's Game of Chair
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

var surrounded = Fn.new{|board, r, c|
    var total = 0
    for(x in max.call(0, r-1)..min.call(board.count-1, r+1)){
        var row = board[x]
        for(y in max.call(0, c-1)..min.call(row.count-1, c+1)){
            if((x!=r || y!=c) && row[y]==1) total = total + 1
        }
    }
    return total
}

var map = {
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

var compareBoards = Fn.new{|a, b|
    a = a.map{|l| l.join("")}.join("\n")
    b = b.map{|l| l.join("")}.join("\n")
    return a==b
}

var game = Fn.new{|board|
    var last = board    // Keep a history
    var new = []
    while(true){
        printBoard.call(last)
        for(r in 0..last.count-1){
            var row = last[r]
            new.add([])
            for(c in 0..row.count-1){
                var pos = row[c]
                if(pos>=0){
                    if(pos==0 && surrounded.call(last, r, c)==0){
                        new[-1].add(1)
                    } else if(pos==1 && surrounded.call(last, r, c)>=4) {
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