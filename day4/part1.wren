/// 
//  Advent of Code 2020 Day 4 Part 1
//  Passport Schmassport. I just never leave home.
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
            System.print("%(required[k]): %(passport[k])")
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