# check if a note for today already exists and open it if so

function notes
    set -l file_name (date +"%Y-%m-%d").md
    set -l notes_dir ~/Documents/Notes/Daily/
    set -l today_note_path "$notes_dir$file_name"

    set -l config_file_dir ~/.config/notes

    # only have to create if it doesn't exist
    if not test -e $today_note_path
        set -l day_of_week (date +"%A")

        # try templates in order of decreasing specificity
        # note to future self: using >> here so I don't blast away existing content by accident
        if test -e "$config_file_dir/$day_of_week.md"
            cat "$config_file_dir/$day_of_week.md" >> $today_note_path
        else if test (date +"%u") -gt 5; and test -e "$config_file_dir/Weekend.md"
            cat "$config_file_dir/Weekend.md" >> $today_note_path
        else if test (date +"%u") -le 5; and test -e "$config_file_dir/Weekday.md"
            cat "$config_file_dir/Weekday.md" >> $today_note_path
        else
            cat "$config_file_dir/Default.md" >> $today_note_path
        end
    end
    # cd here so that I can use telescope etc. in the top level notes dir
    cd $notes_dir/..
    $EDITOR $today_note_path
end

