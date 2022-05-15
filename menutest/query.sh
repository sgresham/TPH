#Part 1 - Query for the user's name
NAME=$(whiptail --inputbox "What is your name?" 8 39 --title "Getting to know you" 3>&1 1>&2 2>&3)
                                                                        
exitstatus=$?
if [ $exitstatus = 0 ]; then
echo "Greetings," $NAME
else
echo "User canceled input."
fi

echo "(Exit status: $exitstatus)"

#Part 2 - Query for the user's country

COUNTRY=$(whiptail --inputbox "What country do you live in?" 8 39 --title "Getting to know you" 3>&1 1>&2 2>&3)
                                                                       
exitstatus=$?
if [ $exitstatus = 0 ]; then
echo "I hope the weather is nice in" $COUNTRY
else
echo "User canceled input."
fi

echo "(Exit status: $exitstatus)"

if (whiptail --title "Is it Tuesday?" --yesno "Is today Tuesday?" 8 78); then
    echo "Happy Tuesday, exit status was $?."
else
    echo "Maybe it will be Tuesday tomorrow, exit status was $?."

fi

if (whiptail --title "Is it Tuesday?" --yesno "Is today Tuesday?" 8 78 --no-button "Not Tuesday" --yes-button "Tuesday"); then
echo "Happy Tuesday, exit status was $?."
else
echo "Maybe it will be Tuesday tomorrow, exit status was $?."
fi
