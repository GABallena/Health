# Function to calculate BMR based on weight, height, age, and gender
def calculate_bmr(weight, height, age, gender='male'):
    if gender == 'male':
        bmr = 10 * weight + 6.25 * height - 5 * age + 5
    else:
        bmr = 10 * weight + 6.25 * height - 5 * age - 161
    return bmr

# Function to calculate maintenance calories based on activity level
def calculate_maintenance_calories(bmr, activity_level='sedentary'):
    activity_multipliers = {
        'sedentary': 1.2,
        'lightly active': 1.375,
        'moderately active': 1.55,
        'very active': 1.725,
        'extra active': 1.9
    }
    return bmr * activity_multipliers.get(activity_level, 1.2)

# Function to ask for activity level
def get_activity_level():
    print("\nChoose your activity level:")
    print("1. Sedentary - little or no exercise")
    print("2. Lightly Active - 30 minutes of elevated heart rate 1-3 days/week")
    print("3. Moderately Active - you workout in the gym or jog for 30-60 mins, 3-5 days/week")
    print("4. Very Active - running, CrossFit, etc. 6-7 days a week")
    print("5. Extra Active - athlete or highly physical job")
    
    activity_choice = input("\nWhat is your activity level (enter the number 1-5)? ")
    
    activity_mapping = {
        '1': 'sedentary',
        '2': 'lightly active',
        '3': 'moderately active',
        '4': 'very active',
        '5': 'extra active'
    }
    
    return activity_mapping.get(activity_choice, 'sedentary')  # Default to sedentary if invalid input

# Main function to get user input and calculate calorie goal
def main():
    # Get user input for goal weight, height, age, and activity level
    goal_weight = float(input("What is your current goal in kg? "))
    height = float(input("What is your height in cm? "))
    age = int(input("What is your age? "))
    gender = input("Are you male or female? ").strip().lower()
    
    # Ask for activity level
    activity_level = get_activity_level()
    
    # Calculate BMR and maintenance calories
    bmr = calculate_bmr(goal_weight, height, age, gender)
    maintenance_calories = calculate_maintenance_calories(bmr, activity_level)
    
    # Output the result
    print(f"\nTo maintain a weight of {goal_weight} kg, with a(n) {activity_level} lifestyle, "
          f"you need approximately {maintenance_calories:.2f} kcal/day.")

if __name__ == "__main__":
    main()
