/// 
//  Advent of Code 2020 Day 10 Part 1
//  I got class.
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
        _waypointN = 1
        _waypointE = 10
        _facingOptions = ["E", "S", "W", "N"]
    }

    facing {
        return _facingOptions[_facing]
    }

    facing = (value) {
        value = (value%360)/90
        for(i in 1..value) {
            var te = _waypointE
            _waypointE = _waypointN
            _waypointN = -te
        }
    }

    forward(distance) {
        _positionN = _positionN + _waypointN * distance
        _positionE = _positionE + _waypointE * distance
    }

    waypointScaled(distance) { [_waypointN * distance, _waypointE * distance] }

    move(direction, distance) {
        if(direction=="F") {
            System.print("Moving by %(this.waypointScaled(distance))")
            this.forward(distance)
        } else if(direction=="N") {
            _waypointN = _waypointN + distance
        } else if(direction=="S") {
            _waypointN = _waypointN - distance
        } else if(direction=="E") {
            _waypointE = _waypointE + distance
        } else if(direction=="W") {
            _waypointE = _waypointE - distance
        } else if(direction=="R") {
            System.write("Rotating right by %(distance) degrees.")
            this.facing = distance
        } else if(direction=="L") {
            System.write("Rotating left by %(distance) degrees.")
            this.facing = 360-distance
        }
    }

    distance { _positionN.abs + _positionE.abs }
    position { [_positionN, _positionE] }
    waypoint { [_waypointN, _waypointE] }
}

var ship = Ship.new()
input.each{ |line|
    ship.move(line[0], line[1])
}
System.print("Final position is %(ship.position), distance is %(ship.distance)")