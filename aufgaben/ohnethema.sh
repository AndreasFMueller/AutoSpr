#
# ohnethema.sh -- Aufgaben ohne Thema-Zuordnung auflisten
#
# (c) 2021 Prof Dr Andreas Müller, OST Ostschweizer Fachhochschule
#
for f in ?/*.tex
do
	if egrep -q '\\themaL?{' $f
	then
		:
	else
		echo $f
	fi
done
