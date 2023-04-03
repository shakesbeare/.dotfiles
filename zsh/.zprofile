if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    setxkbmap -v real-prog-dvorak -option ctrl:nocaps > /dev/null
fi

