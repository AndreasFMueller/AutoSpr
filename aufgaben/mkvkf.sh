#
# mkvkf.sh -- 
#
# (c) 2023 Prof Dr Andreas Müller
#
awk -F, 'BEGIN {
}
/^%/ {
	next
}
{
	printf("%d %d %d %d\n", $1, $2, $3, $4)
}
END {
}' vkf.csv | while read woche kapitel nummer aufgabe
do
	echo Woche: ${woche}
	echo Kapitel: ${kapitel}
	echo Nummer: ${nummer}
	echo Aufgabe: ${aufgabe}
	pdf=vkf/${woche}.${kapitel}.`expr ${nummer} + 1`.pdf
	sed 	-e 's/KAPITEL/'"${kapitel}"'/g' \
		-e 's/NUMMER/'"${nummer}"'/g' \
		-e 's/AUFGABE/'"${aufgabe}"'/g' vkf.template > vkf.tex
	pdflatex --output-directory=work vkf.tex
	mv work/vkf.pdf ${pdf}
done

