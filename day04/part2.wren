/// 
//  Advent of Code 2020 Day 4 Part 1
//  Passport Schmassport. I just never leave home.
//  Added some fun output. Wasn't for debugging or anything, just thought it'd be good fun.
//  @author Patrick Emery

import "io" for File
var input = File.read("input.txt").trim().split("\r\n\r\n")

var required = {
    "byr": "Birth Year",
    "iyr": "Issue Year",
    "eyr": "Expiration Yeah",
    "hgt": "Height",
    "hcl": "Hair Color",
    "ecl": "Eye Color",
    "pid": "Passport ID",
    "cid": "Country ID"
}

var eyeColors = {
    "amb": true,
    "blu": true,
    "brn": true,
    "gry": true,
    "grn": true,
    "hzl": true,
    "oth": true
}
var numbers = "0123456789"
var hexChars = "0123456789abcdef"

var validation = {
    "byr": Fn.new { |input|
        var n = Num.fromString(input)
        return input.count == 4 && 
            n>=1920 &&
            n<=2002
    },
    "iyr": Fn.new { |input|
        var n = Num.fromString(input)
        return input.count == 4 &&
            n>=2002 &&
            n<=2020
    },
    "eyr": Fn.new { |input|
        var n = Num.fromString(input)
        return input.count == 4 &&
            n>=2020 &&
            n<=2030
    },
    "hgt": Fn.new { |input|
        if(input[-2..(input.count-1)] == "cm") {
            var n = Num.fromString(input[0..-3])
            return n>=150 && n<=193
        } else if(input[-2..(input.count-1)] == "in") {
            var n = Num.fromString(input[0..-3])
            return n>=59 && n<=76
        }
        return false
    },
    "hcl": Fn.new { |input|
        if(input[0] == "#") {
            var valid = true
            input[1..input.count-1].each{|char|
                if(hexChars.indexOf(char) == -1) {
                    System.print(char)
                    valid = false
                }
            }
            return valid
        }
        return false
    },
    "ecl": Fn.new { |input|
        return eyeColors[input]
    },
    "pid": Fn.new { |input|
        if(input.count == 9) {
            var valid = true
            input.each{ |char|
                if(numbers.indexOf(char) == -1) {
                    valid = false
                }
            }
            return valid
        }
        return false
    },
    "cid": Fn.new { |input|
        return true
    },
}

var x = 0
var passports = []
input.each { |item|
    item = item.replace(" ", "\n")
    item = item.trim().split("\n")
    var passport = {}
    item.each{|r|
        r = r.split(":")
        passport[r[0]] = r[1..(r.count - 1)].join(":")
    }
    
    var valid = true
    required.keys.each{|k|
        if(passport[k]) {
            if(validation[k].call(passport[k].trim())) {
                System.print("%(required[k]): %(passport[k])")
            } else {
                System.print("This passport has an invalid %(required[k]) [%(passport[k])]")
                valid = false
            }
        } else if(k == "cid") {
            System.print("No CID, but I'll let it slide this time...")
        } else {
            System.print("This passport does not include %(required[k])")
            valid = false
        }
    }
    if(valid) {
        passports.add(passport)
        System.print("\nThis passport is: VALID\n")
    } else {
        System.print("\nThis passport is: INVALID\n")
    }
    System.print("-------------------------------")
}

System.print("\n%(passports.count) Valid Passports")