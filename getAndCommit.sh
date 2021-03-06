set -u
set -e

url="https://www.ueberbrueckungshilfe-unternehmen.de/UBH/Navigation/DE/Dokumente/FAQ/Ueberbrueckungshilfe-III/ueberbrueckungshilfe-lll.html"
regex="<main[^>]*?>(.*)</main>"

if [[ $(curl $url) =~ $regex ]]
then
    content="${BASH_REMATCH[1]}"
    echo $content > ueberbrueckungshilfe-lll.html
else
    echo "Failed: $?"
fi    
