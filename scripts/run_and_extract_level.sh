OUTPUT_DIRECTORY=data/`hostname`_`date +%F`
mkdir -p $OUTPUT_DIRECTORY
THREAD_LEVEL=$1


if test $2 -eq "1"; then
	seq="500000 1000000 2000000 4000000 6000000"
	FILENAME="$OUTPUT_DIRECTORY/multiple_tlevel_`date +%R`_huge_level$THREAD_LEVEL"
elif test $2 -eq "2"; then
	seq="5500000 7300000 9800000"
	FILENAME="$OUTPUT_DIRECTORY/multiple_tlevel_`date +%R`_mega_level$THREAD_LEVEL"
else
	seq="100 1000 10000 50000 100000 250000 550000 800000 1000000 2500000"
	FILENAME="$OUTPUT_DIRECTORY/multiple_tlevel_`date +%R`_level$THREAD_LEVEL"	
fi

touch "$FILENAME.txt"
for i in $seq; do
	echo "Size : $i";
    for rep in `seq 1 5`; do
        echo "Size: $i" >> "$FILENAME.txt";
        ./src/parallelMultiLevel $i $THREAD_LEVEL >> "$FILENAME.txt";
    done ;
done

perl scripts/csv_test_level.pl < "$FILENAME.txt" > "$FILENAME.csv"