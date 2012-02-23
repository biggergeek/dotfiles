# ~/.bash_logout: executed by bash(1) when login shell exits.

# when leaving the console clear the screen to increase privacy

if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
i
# these lines basically just remove duplicates without rearanging

cat ~/.bash_history >> ~/.history
awk '!x[$0]++' ~/.history > ~/.bash_history
cp ~/.bash_history ~/.history
