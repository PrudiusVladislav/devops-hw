#!/bin/bash

ADDRESS_BOOK="address_book.txt"

add() {
    echo "enter name:"
    read name
    echo "enter phone number:"
    read phone
    echo "enter email:"
    read email

    if [[ ! "$phone" =~ ^[0-9]{10}$ ]]; then
        echo "Invalid phone number."
        exit 1
    fi

    if [[ ! "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        echo "Invalid email address."
        exit 1
    fi
    
    echo "$name,$phone,$email" >> "$ADDRESS_BOOK"
    echo "Contact added!"
}

search() {
    echo "enter any search text:"
    read search_text
    
    echo "Search results for '$search_text':"
    grep -i "$search_text" "$ADDRESS_BOOK" || echo "No contacts found."
}

remove() {
    echo "enter name, phone number, or email to remove:"
    read search_text
    
    if grep -i -q "$search_text" "$ADDRESS_BOOK"; then
        grep -i -v "$search_text" "$ADDRESS_BOOK" > temp.txt
        mv temp.txt "$ADDRESS_BOOK"
        echo "Contact removed!"
    else
        echo "Contact not found"
    fi
}

case "$1" in
    add)
        add
        ;;
    search)
        search
        ;;
    remove)
        remove
        ;;
    *)
        echo "Usage: $0 {add|search|remove}"
        ;;
esac
