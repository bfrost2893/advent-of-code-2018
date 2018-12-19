use std::io::{self, BufRead, Read};
use std::collections::HashMap;

fn part1(number_list: &str) {
    let mut result = 0;
    for num in number_list.lines() {
        let val: i32 = num.parse().unwrap();
        result += val;
    }

    println!("Part 1 Result: {}", result);
}

fn part2(number_list: &str) {
    // initialize map of stored results for tracking doubles
    let mut stored_results = HashMap::new();
    stored_results.insert(0, 1);

    // iterate until repeat value is found...
    let mut result = 0;
    loop {
        for num in number_list.lines() {
            let val: i32 = num.parse().unwrap();

            result += val;
            let has_result = stored_results.contains_key(&result);
            if has_result {
                println!("Part 2 Result: {}", result);
                return;
            }

            stored_results.insert(result, 1);
        }
    }
}

fn main() {
    // read in input data from stdin
    let mut input_buffer = String::new();
    io::stdin().read_to_string(&mut input_buffer).ok().expect("Fail to read");

    part1(&input_buffer);
    part2(&input_buffer);
}
