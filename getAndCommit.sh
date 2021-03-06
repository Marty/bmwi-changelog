set -u
set -e

url="https://www.ueberbrueckungshilfe-unternehmen.de/UBH/Navigation/DE/Dokumente/FAQ/Ueberbrueckungshilfe-III/ueberbrueckungshilfe-lll.html"
regex="<main[^>]*?>(.*)</main>"

if [[ $(curl $url) =~ $regex ]]
then
    content="${BASH_REMATCH[1]}"
    filename="${url##*/}"
    echo $content > $filename
    git add $filename
    git commit -m "$(date '+%Y-%m-%d %H:%M:%S') $filename"
    git push origin master
else
    echo "Failed: $?"
fi    
