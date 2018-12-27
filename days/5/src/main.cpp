#include <iostream>
#include <stack>
#include <vector>
#include <cmath>
#include <algorithm>
#include <limits>

std::stack<char> processChain(std::vector<char> inputPolymer) {
  std::stack<char> outputPolymer;

  int i = 0;
  for (const auto &polymerUnit : inputPolymer) {
    unsigned int reacts = 0;
    if (!outputPolymer.empty()) {
      reacts = std::abs(outputPolymer.top() - polymerUnit);
    }

    if (reacts == 32) {
      outputPolymer.pop();
    } else {
      outputPolymer.push(polymerUnit);
    }
    i++;
  }

  return outputPolymer;
}

std::vector<char> readInput() {
  std::vector<char> inputPolymer;

  char polymerUnit;
  while (std::cin >> polymerUnit) {
    inputPolymer.push_back(polymerUnit);
  }

  return inputPolymer;
}

void part1(std::vector<char> inputPolymer) {
  auto outputPolymer = processChain(inputPolymer);

  std::cout << "Part 1 Polymer Size: " << outputPolymer.size() << std::endl;
}

void part2(std::vector<char> inputPolymer) {
  std::string alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

  int smallestChainSize = std::numeric_limits<int>::max();
  for (const auto &letter : alphabet) {
    std::vector<char> filtered;
    std::copy_if(
        inputPolymer.begin(),
        inputPolymer.end(),
        std::back_inserter(filtered), [letter](int l) {
          return l != letter && l != letter + 32;
        });

    auto outputPolymer = processChain(filtered);
    int newSize = outputPolymer.size();
    if (newSize < smallestChainSize) {
      smallestChainSize = newSize;
    }
  }

  std::cout << "Part 2 Polymer Size: " << smallestChainSize << std::endl;
}

int main() {
  std::vector<char> inputPolymer = readInput();
  part1(inputPolymer);
  part2(inputPolymer);
  return 0;
}
