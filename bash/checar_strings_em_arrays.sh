#!/bin/bash 

declare -A urls=(

    ["google"]="www.google.com"

    ["github"]="github.com"

    ["youtube"]="https://www.youtube.com"

)

for key in "${!urls[@]}"; do

    url="${urls[$key]}"

    if [[ ! "$url" =~ ^https:// ]]; then

        urls[$key]="https://$url"

    fi

done

echo "${urls["google"]}"

echo "${urls["github"]}"

echo "${urls["youtube"]}"

