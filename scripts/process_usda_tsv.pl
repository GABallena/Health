#!/usr/bin/perl
use strict;
use warnings;
use POSIX qw(strftime);  # For getting the current timestamp

# Open the input TSV file for reading
my $input_file = 'usda_data.tsv';  # Replace with your actual TSV file name
open(my $in, '<', $input_file) or die "Could not open '$input_file' $!\n";

# Open the output TSV file for writing
my $output_file = 'usda_processed.tsv';
open(my $out, '>', $output_file) or die "Could not open '$output_file' $!\n";

# Print the header for the new TSV file
print $out "Food Item\tProtein (g)\tCarbohydrates (g)\tFats (g)\tCalories (kcal)\tTimestamp\n";

# Get the current timestamp in MM/DD/YYYY HH:MM:SS format
my $timestamp = strftime "%m/%d/%Y %H:%M:%S", localtime;

# Initialize variables to store relevant data
my ($food_item, $protein, $carbs, $fats, $calories);

# Process each line of the input file
while (my $line = <$in>) {
    chomp $line;
    my @fields = split /\t/, $line;

    # Check if it's the header row and skip it
    next if $fields[0] eq 'Food Item';

    # Assign variables
    $food_item = $fields[0];  # Food Item

    # Check for relevant nutrient information
    if ($fields[1] eq 'Protein') {
        $protein = $fields[2];
    } elsif ($fields[1] eq 'Carbohydrate, by difference') {
        $carbs = $fields[2];
    } elsif ($fields[1] eq 'Total lipid (fat)') {
        $fats = $fields[2];
    } elsif ($fields[1] eq 'Energy') {
        $calories = $fields[2];
    }

    # If all nutrients are found for the current food item, print to output
    if (defined $protein && defined $carbs && defined $fats && defined $calories) {
        print $out "$food_item\t$protein\t$carbs\t$fats\t$calories\t$timestamp\n";
        # Reset variables for the next food item
        ($protein, $carbs, $fats, $calories) = (undef, undef, undef, undef);
    }
}

# Close file handles
close($in);
close($out);

print "Processing completed. Data written to 'usda_processed.tsv'.\n";
