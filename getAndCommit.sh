set -u
#set -e

url="https://www.ueberbrueckungshilfe-unternehmen.de/UBH/Navigation/DE/Dokumente/FAQ/Ueberbrueckungshilfe-III/ueberbrueckungshilfe-lll.html"
regex="<main[^>]*?>(.*)</main>"

if [[ $(curl -s $url) =~ $regex ]]
then
    content="${BASH_REMATCH[1]}"
    filename="${url##*/}"
    echo $content > $filename
 
    sed -i -r "s/<sup>([^<]*)<\/sup>\s?/ [\1] /g" $filename
    sed -i -r "s/Druckdatum.*//" $filename 
    sed -i -r "s/<\/?(strong|abbr|sup|a|span|em)\s?[^>]*>//g" $filename
    sed -i -r "s/<[^>]+?>/|/g" $filename
    sed -i -r "s/(\|\s*)+/\n/g" $filename

    git add $filename
    git commit -m "$(date '+%Y-%m-%d %H:%M:%S') $filename" > /dev/null

    if [[ "$?" -ne 0 ]]
    then
        # no changes, ok
	exit 0
    else
        echo "Ueberbrueckungshilfen geaendert!"
	echo 'https://github.com/Marty/bmwi-changelog/commits/master/ueberbrueckungshilfe-lll.html'
        git push origin master > /dev/null 2>&1
        exit 0
    fi
else
    echo "Failed: $?"
fi    
