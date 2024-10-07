rule all:
    input:
        "daily_calories_log.tsv"

rule set_goal:
    output:
        "caloric_goal.txt"
    shell:
        "python3 calorie_goal.py > {output}"

rule fetch_data:
    input:
        "caloric_goal.txt"
    output:
        "usda_data.tsv"
    shell:
        "python3 usda_calories.py"

rule process_data:
    input:
        "usda_data.tsv"
    output:
        "usda_processed.tsv"
    shell:
        "perl process_usda_tsv.pl"

rule summarize_calories:
    input:
        "usda_processed.tsv", "caloric_goal.txt"
    output:
        "daily_calories_log.tsv"
    shell:
        "perl calorie_tracking_with_goal.pl"
