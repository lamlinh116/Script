#!/bin/bash
# 20200701 lamlinh116

echo "+++++++++++++++++++++++++++++++++++++++++++++"
echo "Remove unexpected EOF of the html file"
echo "+++++++++++++++++++++++++++++++++++++++++++++"

# Find in the current directory all the html type files
find . -name '*.html' | while read line; do
    echo "Processing file: '$line'"
	# Find the line number which contains the EOF character </html>
	a=$(grep -n '<\/html>' $line  | gawk '{print $1}' FS=":" )
	echo "Line number of file: $a"
	echo "---------------------------------------------"
	# Remove the unexpected EOF of the html file, and write a tmp.html file
	sed -n ''"$a"',$d;w tmp.html ' $line

	# Add the EOF character correct </html>
	sed -i -e '$a<\/html>' 'tmp.html '
	
	# Copy the correct data to original file
	cp 'tmp.html ' $line
	
	# Remove tmp.html file
	rm 'tmp.html '
done