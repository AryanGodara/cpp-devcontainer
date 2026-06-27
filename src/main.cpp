#include <iostream>
#include <vector>
#include <numeric>
#include <ranges>

int main() {
    std::vector<int> nums{1, 2, 3, 4, 5};

    auto squares = nums | std::views::transform([](int n) { return n * n; });

    std::cout << "C++ devcontainer is up.\n";
    std::cout << "Squares: ";
    for (int s : squares) std::cout << s << ' ';
    std::cout << "\nSum: " << std::accumulate(nums.begin(), nums.end(), 0) << '\n';
    return 0;
}
