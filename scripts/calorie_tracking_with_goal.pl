#!/usr/bin/perl
use strict;
use warnings;

# Get the user's caloric goal (from a file or calculated earlier)
my $goal_file = 'caloric_goal.txt';
open(my $goal_fh, '<', $goal_file) or die "Could not open '$goal_file' $!\n";
my $caloric_goal = <$goal_fh>;
chomp $caloric_goal;  # Remove newline
close($goal_fh);

# Open the processed TSV file for reading
my $input_file = 'usda_processed.tsv';
open(my $in, '<', $input_file) or die "Could not open '$input_file' $!\n";

# Open the log file in append mode, so we don't overwrite previous entries
my $log_file = 'daily_calories_log.tsv';
open(my $log_fh, '>>', $log_file) or die "Could not open '$log_file' $!\n";

# Check if the log file is empty, and if so, write a header
if (-z $log_file) {
    print $log_fh "Date\tTotal Calories (kcal)\tCaloric Goal (kcal)\tDifference (kcal)\n";
}

# Initialize a hash to store total calories for each day
my %calories_per_day;

# Skip the header of the input file
my $header = <$in>;

# Process each line of the input file
while (my $line = <$in>) {
    chomp $line;
    my @fields = split /\t/, $line;

    # Extract the relevant fields
    my $date = $fields[5];  # Timestamp (MM/DD/YYYY)
    my $calories = $fields[4];  # Calories (kcal)

    # Add calories to the total for the corresponding date
    $calories_per_day{$date} += $calories;
}

# Close the input file
close($in);

# Append the total calories for each day to the log file
foreach my $date (sort keys %calories_per_day) {
    my $total_calories = $calories_per_day{$date};
    my $difference = $total_calories - $caloric_goal;  # Calculate the difference

    # Write to the log file
    print $log_fh "$date\t$total_calories\t$caloric_goal\t$difference\n";
}

# Close the log file
close($log_fh);

print "Calorie data appended to 'daily_calories_log.tsv'.\n";
