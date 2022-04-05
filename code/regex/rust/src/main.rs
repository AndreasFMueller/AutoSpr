use std::time::Instant;
use regex::Regex;

fn main() {
    for n in 0 ..= 29 {
        let input = "a".repeat(n);
        let pattern = "a?".repeat(n) + &input;

        let start_time = Instant::now();
        test_regex(&pattern, &input);

        let duration = start_time.elapsed();
        println!("{} matches {} and took {:?}", input, pattern, duration);
    }
}

fn test_regex(pattern: &str, input: &str) {
    let matcher = Regex::new(pattern).unwrap();
    let _ = matcher.is_match(input);
}
