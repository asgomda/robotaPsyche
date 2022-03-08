## 27th February
# Concept
I am planning on basing the project around the Game of Life which some modifications. The Game of life has the following rules: 

- Any live cell with fewer than two live neighbours dies, as if by underpopulation.
- Any live cell with two or three live neighbours lives on to the next generation.
- Any live cell with more than three live neighbours dies, as if by overpopulation.
- Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

These rules, which compare the behavior of the automaton to real life, can be simpplified into the following:

- Any live cell with two or three live neighbours survives.
- Any dead cell with three live neighbours becomes a live cell.
- All other live cells die in the next generation. Similarly, all other dead cells stay dead.

### 1. DNA
I am planning on having three different types of creatures have different features. The characteristics I am considering are speed, reproducibility threshold, size and aggression. Essentially, the three different creatures would be divided into three groups based on the above characteristics.

### 2. Natural Selection
At random intervals, the creatures would develop mutations, in their characteristics and only those who meet some characteristics would be evolve to the next generation.


## 1st March
Today, I refined my idea, and decided to go with a more narrowed down ecosystem. I dedided to have three different types of movers. The first and largest mover I added was the green mover. The green mover is the most aggresive towards food partly because of its mass. The second mover is the purple mover which is the second largest mover in the ecosystem, this mover is attracted to the smallest mover. The last mover I added to the ecosystem was the yellow mover. This mover is repelled by the medium mover and is attracted towards the largest mover, as if for protection. It is consumed when it comes close to the medium mover.


## 2nd March
I finalised the designs and the code for the different movers and their interations. I added reproduction for when the movers have either consumed enough food, or when they are closely lined up. I set the food threshold for reproduction to an arbitrary number which game be the best results. I also split the classes into different tabs for easier navigation.

## 4th March
Added the enemy functionality on click. Whenever the user clickes, a new enemy is generated. The enemy feeds on all the movers and grows in size. As the size grows, the repulsive force gets larger. I also made the aggression inversely proportional to the size of the food available at the time. I did some code clean up as well to get rid of redundant code.

## 6th March
Today, I added the instructions screen before the game starts and finalized the entire interactions in the game. I however encountered an issue where when the user starts the game, the enemies are instantiated by the residual click on the start button. I spent part of the time fixing that error, and I eventually came up with a solution to use a boolean flag to remove any enemies that were created by the residual clicks before the game.

## 8th March
I did not do a lot today, as I had already implemented most of the the details of the game. I spent the most of today, cleaning up and commenting the code, creating a readme.md file and pushing the code to github.

