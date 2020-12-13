/// 
//  Advent of Code 2020 Day 12 Part 1
//  I have barely been using language functions, and what better to school me than class?
//  @author Patrick Emery

import "io" for File
var input = File.read("input.txt").trim().split("\r\n").map{|line|
    return [line[0], Num.fromString(line[1..line.count-1].trim())]
}

class Ship {
    construct new() {
        _facing = 0
        _positionN = 0
        _positionE = 0
        _facingOptions = ["E", "S", "W", "N"]
    }

    facing {
        return _facingOptions[_facing]
    }

    facing = (value) {
        value = (value%360)/90
        _facing = (_facing + value) % _facingOptions.count
    }

    move(direction, distance) {
        if(direction=="F") direction = this.facing
        
        if(direction=="N") {
            _positionN = _positionN + distance
        } else if(direction=="S") {
            _positionN = _positionN - distance
        } else if(direction=="E") {
            _positionE = _positionE + distance
        } else if(direction=="W") {
            _positionE = _positionE - distance
        } else if(direction=="R") {
            this.facing = distance
        } else if(direction=="L") {
            this.facing = -distance
        }
    }

    distance { _positionN.abs + _positionE.abs }
    position{ [_positionN, _positionE] }
}

var ship = Ship.new()
input.each{ |line|
    ship.move(line[0], line[1])
}
System.print("Final position is %(ship.position), distance is %(ship.distance)")