# Baby names utility command
This project was part of the *The Bash Assignment* from the 2XC3 Development Basics course.
In this project I learned to develop a Linux-like utility command written in BASH.
This was quite the interesting experience considering all the syntactical differences BASH introduces which is unique to specifically BASH that no other languages have.

### Technologies
<p align="center">
    <img src="https://img.shields.io/badge/GNU%20Bash-4EAA25?style=for-the-badge&logo=GNU%20Bash&logoColor=white">
    <img src="https://img.shields.io/badge/GIT-E44C30?style=for-the-badge&logo=git&logoColor=white">
    <img src="https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white">
    <img src="https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white">
</p>

### How to use the utility command
Usage: `./bn.sh <year> <assigned gender: f|F|m|M|b|B>`  
Year is between 1800 to 2024 (Note that some years don't have data on them like 2024).  
Gender is a single character which can be f, F, m, M, b, or B.

Run `./bn.sh --help` for more help and information

Run `./test_script` to run a bunch of tests  
More tests for GitHub Actions is found in `.github/workflows/test.yml`