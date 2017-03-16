/*
 * regex.cpp -- Regex-Matcher der C++-Library testen
 *
 * (c) 2016 Hansruedi Patzen, HSR
 */

#include "regex.h"

#include <ostream>
#include <regex>
#include <string>
#include <chrono>

namespace Regex {

void test(std::ostream & out, std::size_t const & numberOfRounds) {
	std::string regexString { };
	std::string searchString { };

	auto begin = std::chrono::high_resolution_clock::now();

	for (std::size_t i = 0; i < numberOfRounds; i++) {
		regexString += "a?";
		searchString += "a";
		std::string pattern { regexString + searchString };
		std::regex regex { pattern };

		out.width(numberOfRounds);
		out << searchString << (std::regex_match(searchString, regex) ? " matches " : " doesn't match ") << pattern << '\n';
	}

	auto end = std::chrono::high_resolution_clock::now();
	out << "Runtime: " << std::chrono::duration_cast<std::chrono::nanoseconds>(end - begin).count() << "ns" << '\n';
}

} // namespace Regex
