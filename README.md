# random_verse

Permutation Analysis and Visualization Project
Developed a comprehensive application in Rust and Flutter to analyze random permutations of integers and visualize the distribution of the maximum cycle length.

The project involved the following key components:

1.Random Permutation Generation: Implemented an algorithm to generate random permutations of integers from 1 to n, based on the approach described in the "Introduction to Algorithms" book.
2.Cycle Decomposition: Designed and implemented a algorithm to decompose the generated permutations into disjoint cycles, utilizing efficient data structures for tracking visited nodes and cycle lengths.
3.Maximum Cycle Length Computation: Developed a module to calculate the maximum length among all cycles in a given permutation, enabling the analysis of the longest cycle's behavior.
4.Monte Carlo Simulation: Conducted a Monte Carlo simulation with 10,000 random permutations of length 100 to estimate the expected length of the maximum cycle in a random permutation.
5.Modular Design and Testing: Employed a modular design approach, creating well-defined function specifications and method signatures. Implemented comprehensive test cases using black-box testing techniques to ensure the correctness of the codebase.
6.Flutter Application: Developed a user-friendly Flutter application to encapsulate the permutation analysis functionality and display the results, including the estimated expected length of the maximum cycle in a random permutation.
7.Visualization and Distribution Analysis: Optionally, recorded the maximum cycle lengths for all 10,000 permutations, sorted the data, and devised a technique to summarize the distribution using a concise set of representative values, enabling visual presentation and analysis of the maximum cycle length distribution.

Technologies Used: Rust, Flutter, Data Structures, Algorithms, Monte Carlo Simulation, Testing, Design Patterns.
