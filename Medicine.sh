#!/bin/bash

# Medicine Store Management Script

# Function to display the menu
display_menu() {
    echo "---------------------------------"
    echo "Himel Kashfea Naila Rakib's Medicine Store Management System"
    echo "---------------------------------"
    echo "1. Add Medicine"
    echo "2. Update Medicine"
    echo "3. Delete Medicine"
    echo "4. Search Medicine"
    echo "5. View All Medicines"
    echo "6. Exit"
    echo "---------------------------------"
}

# Function to add a new medicine
add_medicine() {
    echo "Enter the details of the medicine:"
    read -p "Name: " name
    read -p "Manufacturer: " manufacturer
    read -p "Price: " price
    echo "$name,$manufacturer,$price" >> medicines.csv
    echo "Medicine added successfully!"
}

# Function to update an existing medicine
update_medicine() {
    echo "Enter the name of the medicine to update:"
    read -p "Name: " name
    if grep -q "$name" medicines.csv; then
        echo "Enter the new details of the medicine:"
        read -p "Manufacturer: " manufacturer
        read -p "Price: " price
        sed -i "s/^$name,.*/$name,$manufacturer,$price/" medicines.csv
        echo "Medicine updated successfully!"
    else
        echo "Medicine not found."
    fi
}

# Function to delete a medicine
delete_medicine() {
    echo "Enter the name of the medicine to delete:"
    read -p "Name: " name
    if grep -q "$name" medicines.csv; then
        # Create a temporary file
        tmp_file=$(mktemp)

        # Copy all lines except the one to be deleted to the temporary file
        grep -v "^$name," medicines.csv > "$tmp_file"

        # Overwrite the original file with the temporary file
        mv "$tmp_file" medicines.csv

        echo "Medicine deleted successfully!"
    else
        echo "Medicine not found."
    fi
}


# Function to search for a medicine
search_medicine() {
    echo "Enter the name of the medicine to search:"
    read -p "Name: " name
    if grep -q "$name" medicines.csv; then
        grep "$name" medicines.csv
    else
        echo "Medicine not found."
    fi
}

# Function to view all medicines
view_medicines() {
    echo "List of all medicines:"
    cat medicines.csv
}

# Main script
while true; do
    display_menu
    read -p "Enter your choice (1-6): " choice
    case $choice in
        1) add_medicine ;;
        2) update_medicine ;;
        3) delete_medicine ;;
        4) search_medicine ;;
        5) view_medicines ;;
        6) exit ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
    echo
done
