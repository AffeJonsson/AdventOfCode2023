#import "Basic";
#import "Print_Color";
#import "Windows";
#import "File";
#import "String";

main :: () {
    file_data, success := read_entire_file("input.txt");
    if (!success) return;
    
    valid_names :: string.["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"];
    sum_part_1 := 0;
    sum_part_2 := 0;
    rows := split(file_data, "\n");
    for row: rows {
        first_index := find_index_of_any_from_left(row, "0123456789");
        last_index := find_index_of_any_from_right(row, "0123456789");
        first_length := ifx first_index < 0 then 0 else 1;
        last_length := ifx last_index < 0 then 0 else 1;
        first := ifx first_index < 0 then 0 else row[first_index] - #char "0";
        last := ifx last_index < 0 then 0 else row[last_index] - #char "0";
        sum_part_1 += first * 10 + last;
        
        for valid_names {
            index := find_index_from_left(row, it);
            if index < 0  continue;
            
            if index < first_index || first_index < 0 {
                first_index = index;
                first = cast(u8)it_index + 1;
                first_length = it.count;
            }
            
            index = find_index_from_right(row, it);
            if index > last_index || last_index < 0 {
                last_index = index;
                last = cast(u8)it_index + 1;
                last_length = it.count;
            }
        }
        
        print(slice(row, 0, first_index));
        print_color(slice(row, first_index, first_length), color=.GREEN);
        if first_index != last_index {
            print(slice(row, first_index + first_length, last_index - first_index - first_length));
            print_color(slice(row, last_index, last_length), color=.GREEN);
        }
        print(slice(row, last_index + last_length, row.count - last_index - last_length));
        print(" %\n", first * 10 + last);
        sum_part_2 += first * 10 + last;
    }
    print("Part1: %, Part2:%\n", sum_part_1, sum_part_2);   
}