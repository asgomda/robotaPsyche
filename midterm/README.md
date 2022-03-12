## Concept
My initial concept was to base the ecosystem off of the game of life which has rules the following rules: 
1. Any live cell with two or three live neighbours lives on to the next generation.
2. Any live cell with more than three live neighbours dies, as if by overpopulation.
3. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

However, these rules were not very clear to implement, and the interaction were limited. So I decided to adapt it with the following three main features which are feeding, reproduction, and death. In the ecosystem, there are three movers that the ecosystem is based around. 

- The first is the green mover which is the largest mover in the ecosystem. Due to its size, it is the most aggresive towards food. The level of aggression is inversely related to the amount of food present. Meaning, the the smaller the amount of food remaining at that time, the more aggresive the movers will be. 
- The second mover is the purple mover which is the second largest mover in the ecosystem. This mover feeds on the smaller mover and has a medium aggression level. 
- The final mover is the yellow mover and it is the smallest mover in the ecosystem. This mover is attracted towards the largest mover (as if for protection) and is repelled by the medium mover.

## Process
I started off by deciding the specific instructions and interactions the ecosystem would have. After I did this, I implemented the movers, attractors and enemies and lastly implemented the interactions. 

<!-- - Any live cell with fewer than two live neighbours dies, as if by underpopulation.
- Any live cell with two or three live neighbours lives on to the next generation.
- Any live cell with more than three live neighbours dies, as if by overpopulation.
- Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

The concept
The process you took to achieve it
Problems if any, and solutions or workarounds
Anything interesting you discovered or learned
Any resources you found useful (tutorials, books, friends, ideas from other classes, etc.)

### 1. DNA
I am planning on having three different types of creatures have different features. The characteristics I am considering are speed, reproducibility threshold, size and aggression. Essentially, the three different creatures would be divided into three groups based on the above characteristics.

### 2. Natural Selection
At random intervals, the creatures would develop mutations, in their characteristics and only those who meet some characteristics would be evolve to the next generation. -->
