// ArraysVsLists.swift
//
// Created by Remy Skelton
// Created on 2025-03-26
// Version 1.0
// Copyright (c) 2025 Remy Skelton. All rights reserved.
//
// This program prompts the user to select a file (1, 2, or 3) to process.
// It then reads integer values from the chosen file and displays the mean and median of those integers.
//

// Import Foundation library
import Foundation

// Function to calculate the mean
func calcMean(arrayInt: [Int]) -> Double {
    // Initialize the sum
    var sum = 0.0

    // Iterate through the array
    for num in arrayInt {
        // Add the integer of the current index to the sum
        sum += Double(num)
    }

    // Return the mean
    return Double(sum) / Double(arrayInt.count)
}

// Function to calculate the median
func calcMedian(arrayInt: [Int]) -> Double {
    // Initialize the median
    var median = 0.0

    // If the length of the array is even
    if arrayInt.count % 2 == 0 {
        // Find the two middle indexes
        let medianIndex1 = arrayInt.count / 2
        let medianIndex2 = medianIndex1 - 1

        // Calculate the median
        median = Double((arrayInt[medianIndex1] + arrayInt[medianIndex2])) / 2.0
    } else {
        // If the length of the array is odd
        // Find the middle index
        let medianIndex = arrayInt.count / 2

        // Set the value at the middle index to the median
        median = Double(arrayInt[medianIndex])
    }

    // Return the median
    return median
}

// Initialize the file name outside of the loop
var fileName = ""

repeat {
    // Ask the user for the file name
    print("Enter the number set you would like to use (1, 2 or 3), or 'q' to quit: ", terminator: "")

    // Get the file name input
    // If the user enters nothing, replace nil with an empty string
    fileName = readLine() ?? ""

    // Check if the user wants to quit
    if fileName == "q" {
        // Display goodbye message
        print("Goodbye!")
    } else if (fileName != "1") && (fileName != "2") && (fileName != "3") {
        // If the input is invalid
        print("Invalid input. Please enter a number set (1, 2, or 3).")
    } else {
        // Set the file name
        let fileNameWithPath = "Unit2-06-Set\(fileName).txt"
        do {
            // Read the contents of the file
            let file = try String(contentsOfFile: fileNameWithPath, encoding: .utf8)

            // Initialize the array of numbers
            var numbers: [Int] = []

            // Split the file into lines
            let lines = file.split(separator: "\n")

            // Split each line into numbers
            for line in lines {
                // The numbers are separated by spaces
                let numberStrings = line.split(separator: " ")

                // Convert the strings of numbers to integers
                for numStr in numberStrings {
                    // Convert the string to an integer
                    if let number = Int(numStr) {
                        // Add the integer to the array
                        numbers.append(number)
                    }
                }
            }

            // Sort the array of numbers
            let sortedArray = numbers.sorted()

            // Call the mean and median from each function
            let mean = calcMean(arrayInt: sortedArray)
            let median = calcMedian(arrayInt: sortedArray)

            // Create the output file name
            let outputFileName = "Unit2-06-set\(fileName)-output.txt"

            // Reset the output string
            var outputStr = ""

            // Write the sorted array directly to an output string
            // One number at a time, separated by spaces
            for number in sortedArray {
                // Write the number to the output string
                outputStr += String(number) + " "
            }

            // Add a new line to the output string
            outputStr += "\n"

            // Add the mean and median to the output string
            outputStr += "Mean: \(mean)\n"
            outputStr += "Median: \(median)\n"

            // Check for any errors
            do {
                // Source: https://developer.apple.com/documentation/foundation/nsstring/1497362-write
                // Write the output string to the output file
                // Atomically means that the file will be written to a temporary file first
                // This prevents data loss if the write fails or if the file gets overwritten
                try outputStr.write(toFile: outputFileName, atomically: true, encoding: .utf8)

                // Display success message
                print("The file " + fileNameWithPath + " was written successfully.")
            } catch {
                // If the file cannot be written
                print("Error writing to file.")
            }
        } catch {
            // If the file cannot be read
            print("Error reading the file.")
        }
    }
// Keep looping until the user enters 'q'
} while fileName != "q"