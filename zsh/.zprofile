if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    setxkbmap -v real-prog-dvorak -option ctrl:nocaps
fi

xrandr --output DP-2 --mode 1920x1080 --rate 119.98
