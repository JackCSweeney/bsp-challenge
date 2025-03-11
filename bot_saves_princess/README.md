# Challenge 1
Princess Peach is trapped in one of the four corners of a square grid. You are in the center of the grid and can move one step at a time in any of the four directions. Can you rescue the princess?

### Input format:
The first line contains an odd integer N (3 <= N < 100) denoting the size of the grid. This is followed by an NxN grid. Each cell is denoted by '-' (ascii value: 45). The bot position is denoted by 'm' and the princess position is denoted by 'p'.

Grid is indexed using Matrix Convention

### Output format
Print out the moves you will take to rescue the princess in one go. The moves must be separated by '\n', a newline. The valid moves are LEFT or RIGHT or UP or DOWN.

### Sample input
```
3
---
-m-
p--
```
### Sample output
```
DOWN
LEFT
```
### Task
Complete the function displayPathtoPrincess which takes in two parameters - the integer N and the character array grid. The grid will be formatted exactly as you see it in the input, so for the sample input the princess is at grid[2][0]. The function shall output moves (LEFT, RIGHT, UP or DOWN) on consecutive lines to rescue/reach the princess. The goal is to reach the princess in as few moves as possible.

The above sample input is just to help you understand the format. The princess ('p') can be in any one of the four corners.

### Scoring
Your score is calculated as follows : (NxN - number of moves made to rescue the princess)/10, where N is the size of the grid (3x3 in the sample testcase).

### Starting Code from HackerRank
```
#!/bin/ruby

def displayPathtoPrincess(n,grid)
  return ""
end

m = gets.to_i

grid = Array.new(m)

(0...m).each do |i|
    grid[i] = gets.strip
end

displayPathtoPrincess(m,grid)
```

## Planning Notes
### Consolidated Challenge Overview
- Task is to create a program that will take two arguments, n and grid, and return the directions that the robot within the grid will have to take in order to get to the princess in the least amount of steps possible
  - Constraints:
    - n will always be an odd integer between 3 and 100, denotes the size of the grid being input
    - m will always be in the center of the grid
    - grid will always have individual cells denoted by a dash/flag '-'
    - grid will contain an 'm' representing the robot
    - grid will contain a 'p' representing the princess
    - The final output should be consecutive lines printing the directions taken to reach the princess (i.e. LEFT, RIGHT, UP, DOWN)

### Initial Thoughts
- Will need to build some initial test cases for final result
  - Can add additional tests as different edge cases are identified and as the problem is broken down into different parts
- Will want to keep in mind object oriented design principles throughout
  - Lean on the 4 pillars where it makes sense (Abstraction, Polymorphism, Encapsulation, Inheritance)
- Will want to adhere to SRP, so building out some different classes and utilizing helper methods where needed
- Probably a good idea to build in some error handling for incorrect input
- Can create a runner file for it to run on its own within the terminal
- Can create a separate file to combine all of the different code that should be copy pasted into the HackerRank challenge page

- Problem aspects:
  - Since the input for the problem is coming from STDIN, will need to use 'gets' or 'ARGF'
    - Good spot to build a specific class to handle the input
    - Good spot to include some error handling from the input that is received
  - Traversing a matrix
    - Since we are only receiving the matrix/grid and its size, not only do we have to traverse the matrix to find the quickest path to princess, also have to find where the robot is starting from and where the princess is located
      - Could potentially have the process that builds the grid identify where the robot starts and where the princess is, then create them as objects that store their locations
      - This would prevent having to iterate through the matrix multiple times to find them after grid is created
      - Alternatively, could have the grid be created and use lazy loading to find the princess and robot, but this seems like it may still be a slower/inefficient process compared to having them be created as the grid is being made
    - If the bot and princess are each their own class, and have their coordinates saved as attributes, finding the quickest path becomes fairly simple since the number of steps needed to be taken would be the difference of each coordinates sum (it's absolute value)
      - Since we need to print the steps to get there though, will have to instead just add/subtract from x and y coords of bot to make its coords match princess, and depending on which it does, print those directions, or store them as an attribute for the bot
  
- Planning:
  - Have PrincessSaver class that is responsible for creating final output from stdin input
  - Have bot class that contains attributes of its location coordinates
    - will also hold onto logic for creating directions to princess
  - Have princess class that contains attributes of its location coordinates
  - Have InputReader class that will read from the stdin and create bot, princess, and matrix? might not even need matrix since we can just grab the coords as it comes in, but we will want to also store the size
  - Matrix class that holds onto the size and rows of matrix, will also hold onto robot and princess objects
  - Runner file to make it run in terminal

# Challenge 2
In this version of "Bot saves princess", Princess Peach and bot's position are randomly set. Can you save the princess?

### Task
Complete the function nextMove which takes in 4 parameters - an integer N, integers r and c indicating the row & column position of the bot and the character array grid - and outputs the next move the bot makes to rescue the princess.

### Input Format
The first line of the input is N (<100), the size of the board (NxN). The second line of the input contains two space separated integers, which is the position of the bot.

Grid is indexed using Matrix Convention

The position of the princess is indicated by the character 'p' and the position of the bot is indicated by the character 'm' and each cell is denoted by '-' (ascii value: 45).

### Output Format
Output only the next move you take to rescue the princess. Valid moves are LEFT, RIGHT, UP or DOWN

### Sample Input
```
5
2 3
-----
-----
p--m-
-----
-----
```
### Sample Output
```
LEFT
```
### Resultant State
```
-----
-----
p-m--
-----
-----
```
### Explanation
As you can see, bot is one step closer to the princess.

### Scoring
Your score for every testcase would be (NxN minus number of moves made to rescue the princess)/10 where N is the size of the grid (5x5 in the sample testcase). Maximum score is 17.5

## Planning Notes
### Consolidated Overview
- The bot and princess are now able to be placed in different positions on the grid instead of just the corners for princess and center for bot
- Program will now receive 4 different inputs, size of grid, then row placement of bot, then column placement of bot, then the grid
- Now, the output should not be the entire list of moves to get to the princess, but only the next move that needs to be made

### Initial Thoughts
- Can reuse most of what has already been built
- Could potentially utilize a module for some of the new behavior that will exist?
  - Would love to introduce some inheritance somewhere that it makes sense, but don't want to force it for the sake of it
- Can utilize the same input reader methods for matrix size and rows, plus their validations, will just need to add in a method to get bot placement
- Can use same directions to princess method from bot since it's just using the coordinates from each
- Could swap back to old find_princess method/rewrite to search for it so that it's the same through both problems
- If I use some sort of conditional statement when the input reader is reading the second line of input, it could check if the first char is an int, if yes, it runs through the solution for problem 2, if no it runs through the solution for problem 1

- Planning:
  - Update directory name to just be bsp
  - Add method to input_reader to get the bot coordinates from input, include condition that checks if input being received is the start of the rows or the coordinates of bot
    - May need to change creation of bot? will definitely need to have new attribute for the bot coords in input reader
  - Update find_princess method / add new one that is called based what input was received
  - Add next_move method to robot that pulls the next move out of directions and returns it
  - Update save_princess method to only puts the first direction if challenge 2 is detected
    - Could add an attribute to the saver that defaults to false unless the second input detected is the coordinates