#import "Math";
#import "Basic";
#import "Windows";
#import "File";
#import "String";

maybe_count_number :: (rows: []string, row_index: int, start_index: int, str_num: String_Builder) -> int {
    found := false;
    for r: row_index - 1..row_index + 1 {
        if r < 0 continue;
        if r >= rows.count continue;
        row_to_check := rows[r];
        for c: start_index - 1..start_index + builder_string_length(*str_num) {
            if c < 0 continue;
            if c >= row_to_check.count continue;
            char_to_check := row_to_check[c];
            if (char_to_check < #char "0" || char_to_check > #char "9") && char_to_check != #char "." {
                str := builder_to_string(*str_num, do_reset = false);
                return string_to_int(str);
            }
        }
    }
    return 0;
}

Point :: struct {
    x: int;
    y: int;
}

Number :: struct {
    minX: int;
    maxX: int;
    y: int;
    number: int;
}

main :: () {
    file_data, success := read_entire_file("input.txt");
    if (!success) return;
    rows := split(file_data, "\n");
    sum := 0;
    product_sum := 0;
    str_num : String_Builder;
    asterisks: [..]Point;
    numbers: [..]Number;
    init_string_builder(*str_num);
    for row, row_index: rows {
        reset(*str_num);
        start_index := -1;
        for 0..row.count - 1 {
            char := row[it];
            if char == #char "*" {
                array_add(*asterisks, .{ x = it, y = row_index });
            }
            if char >= #char "0" && char <= #char "9" {
                append(*str_num, char);
                if start_index < 0  start_index = it;
                if it == row.count - 1 {
                    count := maybe_count_number(rows, row_index, start_index, *str_num);
                    sum += count;
                    reset(*str_num);
                    if count > 0 {
                        array_add(*numbers, .{ minX = start_index, maxX = it, y = row_index, number = count });
                    }
                    start_index = -1;
                }
            } else if start_index >= 0 {
                count := maybe_count_number(rows, row_index, start_index, *str_num);
                sum += count;
                reset(*str_num);
                if count > 0 {
                    array_add(*numbers, .{ minX = start_index, maxX = it - 1, y = row_index, number = count });
                }
                start_index = -1;
            }
        }
    }
    for asterisk: asterisks {
        count := 0;
        product := 0;
        for numbers {
            if abs(it.y - asterisk.y) > 1 continue;
            if abs(it.minX - asterisk.x) > 1 && abs(it.maxX - asterisk.x) > 1 continue;
            count += 1;
            if product == 0 product = it.number;
            else product *= it.number;
        }
        if count == 2 {
            product_sum += product;
        }
    }
    print("Part 1: %, part 2: %\n", sum, product_sum);
}