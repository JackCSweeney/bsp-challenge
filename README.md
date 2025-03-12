# <p style="text-align: center;">Bot Saves Princess</p>

## About
This repository is my solution to the [Bot Saves Princess](https://www.hackerrank.com/challenges/saveprincess) and [Bot Saves Princess 2](https://www.hackerrank.com/challenges/saveprincess2) challenges from HackerRank for a SESAC take home coding challenge. Below you can find instructions on what code should be pasted into the solution section of both challenges, how to run the test suite, and how to utilize the runner file to run the code locally in your terminal. You will also find information about my approach to this challenge, reasoning behind design decisions, challenging areas through the process of implementing this solution, and potential changes or additions.

### Code for HackerRank Website
**For First Challenge:**
- Copy lines 1 - 160 from hacker_rank_solution.rb file
- Paste code into code editor at bottom of [this page](https://www.hackerrank.com/challenges/saveprincess)
- Select Ruby as language if not already selected in drop down menu at top of code editor
- Click 'Run Code'
- Click play button in Game 1 box that appears after loading has completed

**For Second Challenge:**
- Copy lines 1 - 152 and 163-169 from hacker_rank_solution.rb file
- Paste code into code editor at bottom of [this page](https://www.hackerrank.com/challenges/saveprincess2)
- Select Ruby as language if not already selected in drop down menu at top of code editor
- Click 'Run Code'
- Click play button in Game 1 box that appears after loading has completed

### How to Setup and Run Locally
1. Clone repository
```
git clone git@github.com:JackCSweeney/bsp-challenge.git
```
2. Install dependencies
```
bundle install
```
3. Run test suite
```
bundle exec rspec 
```
4. Run runner.rb file and follow instructions in terminal
```
ruby runner.rb
```

### Approach
- Overview:
  - With both problems, while there are simpler solutions that would require less code, I was focused on solving them utilizing strong object oriented design principles and styles. I kept a strong goal throughout the design and implementation process to be able to reutilize as much code as possible for both challenges.

- Princess
  - This class is very simple and is only responsible for knowing its own position within the matrix through the inclusion of the Positionable module

- Robot
  - This class is also fairly simple, but in addition to knowing its own position within the matrix, it also inherits the behavior of changing its x and y axis positions within the matrix from the Positionable module
  - Methods:
    - `directions_to_princess(princess_coordinates)` - Once the Robot receives the Princess' coordinates, it utilizes the DirectionManager class to calculate the directions to reach her
    - `next_move` - Utilizes its array of directions to identify which way it needs to move next and utilizes the `move_on_x_axis` and `move_on_y_axis` methods from Positionable to change its coordinates. Returns a string with the direction it moved ("LEFT", "UP", "RIGHT", or "DOWN")

- Positionable
  - This module was added to share the responsibility of initializing both Robot and Princess with their coordinates
  - Methods:
    - `move_on_y_axis(amount)` - Utilizes the integer value given in the argument to increase or decrease the value of the y coordinate of the object it is called on
    - `move_on_x_axis(amount)` - Utilizes the integer value given in the argument to increase or decrease the value of the x coordinate of the object it is called on
  - Note:
    - While the Princess doesn't ever move in these challenges, I felt utilizing a module for this behavior would allow for future flexibility if challenge constraints were to change (What if the robot needs saving one day!?!?)

- DirectionManager
  - This class is responsible for managing calculating the directions from the Robot's position to the Princess' position and initializing with the start and target positions used for the calculation
  - Methods:
    - `y_axis_directions` - Calculates the distance from the start position y coordinate and target position y coordinate and adds either "UP" or "DOWN" to the directions array
    - `x_axis_directions` - Calculates the distance from the start position x coordinate and target position x coordinate and adds either "LEFT" or "RIGHT" to the directions array
    - `calculate_directions` - Utilizes x and y axis direction methods to gather all directions and returns the directions array

- Matrix
  - This class holds the responsibility of knowing the size of the grid the Princess and Robot are on, creating a Matrix out of the STDIN received from the InputReader, finding the coordinates of both the Princess and Robot, and instantiating both the Princess and Robot
  - Initializes with arguments of `size`, `rows`, and an optional argument of `robot_coordinates` for challenge 2
  - Methods:
    - `coordinates_for_princess` - Flattens the matrix created from the rows initialized with to avoid nested iteration and searches for the location of the princess, returning a hash of the x and y coordinates
      - Utilized in initialize method to create Princess object
    - `coordinates_for_robot` - Returns either the coordinates provided during instantiation or sets the coordinates to be the center of the grid if not provided, returning a hash of the x and y coordinates
      - Utilized in initialize method to create Robot object

- InputReader
  - This class is responsible for reading, validating, and holding onto all of the information from STDIN and is initialized with default values for size, matrix_rows, and robot_coordinates (for challenge 2)
  - Methods:
    - `get_matrix_size` - Retrieves the size of the matrix from STDIN and calls a custom validation before storing the size as an instance variable
    - `get_matrix_rows` - Retrieves all of the rows of the matrix from STDIN and calls a custom validation before storing the rows as an instance variable
    - `get_robot_coordinates` - Retrieves the Robot coordinates on the matrix from STDIN and calls a custom validation before storing the coordinates as an instance variable (only used for challenge 2)
    - `validate_size_input(non_validated_size)` - Validates that the size from STDIN is an odd number between 3 and 100 and returns the number or raises ArgumentError
    - `validate_row_input(non_validated_rows)` - Validates that the length and number of rows from STDIN match the size previously input and returns the rows or raises ArgumentError
    - `validate_robot_coordinates(x:, y:)` - Validates that both coordinates for Robot from STDIN are present and within the matrix range, returning the coordinates as a hash or raising ArgumentError

- PrincessSaver
  - This class is responsible for starting all of necessary processes to save the princess for both challenges
  - Instantiates an instance of InputReader on initialize
  - Methods:
    - `make_matrix` - Creates an instance variable of a Matrix, utilizing the input reader for the size, rows, and robot_coordinates
    - `directions_to_princess` - Utilizes the instance variable of Matrix to return the array of directions from Robot
    - `next_move_to_save_princess` - Utilizes the instance variable of Matrix to have the directions created for the Robot and return only the next move it will make towards the princess

### Challenges Encountered
- Throughout the process of planning and implementation, I felt there were lots of arguments for why specific classes should hold different responsibilities and just as many for why they maybe shouldn't
  - The decisions ended up coming down to what would keep each class simple and be the most clear on why it has the responsibility it does
  - Creating the different classes in a way that would allow for the most flexibility also helped a lot of the decision making
  - Thinking of potential future constraints that could be added to the problem and if anything about my implementation would make those more difficult to handle was another helpful factor along with making sure that the code would work for both challenges with little to no changes
- Testing multiple sequential inputs from STDIN proved to be difficult at times when stubbing the inputs as it would continue on to the next input immediately after gets was called, which wasn't reflective of the same behavior when manually testing the code or testing it in the Hacker Rank website
  - This led to a few changes with how `gets` was used by the InputReader in order to make the code more testable, sacrificing a few extra lines of code to store the input in a temporary variable, preventing it from making additional calls of `gets` before finishing any of its validations

### Potential Changes / Additions
- Since both Hacker Rank challenges are solved by the current code, these would likely just be optimizations or fun additions to implement in the future
  - Currently, only the coordinates of the Robot change when `next_move` is called. If you were to want to make it into more of a *game*, having the board update the location of the Robot as well and display that with each move would be a nice addition
  - Setting up the runner.rb file so that it returns what the board looks like after each move would be a fun touch and would require the above addition/change
  - More thorough validations to handle more potential edge cases would be a nice addition
  - I'm uncertain of if it would be much more efficient or not (especially at smaller scales), but when the input is being read by InputReader, potentially flagging the location of the Princess and passing that through the classes rather than searching for it afterwards may be an optimization area
  - Adding a Movable module to hold onto the movement logic from Positionable would potentially add a little bit of clarity to the responsibilities of both