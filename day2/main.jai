#import "Hash_Table";
#import "Basic";
#import "Print_Color";
#import "Windows";
#import "File";
#import "String";

main :: () {
    file_data, success := read_entire_file("input.txt");
    if (!success) return;
    max: Table(string, int);
    min: Table(string, int);
    table_add(*max, "red", 12);
    table_add(*max, "green", 13);
    table_add(*max, "blue", 14);
    table_add(*min, "red", 0);
    table_add(*min, "green", 0);
    table_add(*min, "blue", 0);
    rows := split(file_data, "\n");
    
    sum := 0;
    power := 0;
    for row: rows {
        data := split(row, ":");
        game := string_to_int(split(data[0], " ")[1]);
        bags := split(data[1], ";");
        print("Bags for game %: %\n", game, bags);
        success := true;
        table_set(*min, "red", 0);
        table_set(*min, "green", 0);
        table_set(*min, "blue", 0);
        for bag: bags {
            x := split(bag, ",");
            for ball: x {
                s := split(ball, " ");
                num := string_to_int(s[1]);
                color := s[2];
                
                if color[color.count - 1] == #char "," then color.count -= 1;
                print("Color: %, num: %\n", color, num);
                min_value_for_color, find_success := table_find(*min, color);
                if min_value_for_color < num {
                    table_set(*min, color, num);
                }
                max_value_for_color: , find_success = table_find(*max, color);
                if (!find_success || num > max_value_for_color) {
                    print("Color % (%) is larger than max: %\n", color, num, max_value_for_color);
                    success = false;
                }
            }
        }
        red, find_success := table_find(*min, "red");
        green: , find_success = table_find(*min, "green");
        blue: , find_success = table_find(*min, "blue");
        power += red * green * blue;
        if success  sum += game;
    }
    print("Part 1: %, part 2: %\n", sum, power);
}