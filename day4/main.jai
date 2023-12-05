#import "Math";
#import "Basic";
#import "Windows";
#import "File";
#import "String";

main :: () {
    file_data, success := read_entire_file("input.txt");
    if (!success) return;
    rows := split(file_data, "\n");
    scores : []int;
    array_resize(*scores, rows.count);    
    score := 0;
    cards := rows.count;
    for row, row_index: rows {
        s := split(row, ":");
        numbers := split(s[1], "|");
        correct := split(replace(trim(numbers[0]), "  ", " "), " ");
        actual  := tprint("% ", numbers[1]);
        current_score := 0;
        new_cards := 0;
        for c: correct {
            if find_index_from_right(actual, tprint(" % ", c)) >= 0 {
                if current_score == 0  current_score = 1;
                else current_score *= 2;
                new_cards += 1;
            }
        }
        for row_index + 1..row_index + new_cards {
            scores[it] += 1 + scores[row_index];
        }
        score += current_score;
    }
    for scores  cards += it;
    print("Part 1: %, part 2: %\n", score, cards);
}