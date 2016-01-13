OUTPUT_DIRECTORY=data/`hostname`_`date +%F`
mkdir -p $OUTPUT_DIRECTORY
FILENAME="$OUTPUT_DIRECTORY/measurements_`date +%R`"

seq=$(cat $1)
n=1

touch "$FILENAME.txt"
for i in $seq; do
	echo $n $i
	n=$(($n+1))
	#echo "Size : $i";
    for rep in `seq 1 2`; do
        echo "Size: $i" >> "$FILENAME.txt";
        ./src/parallelQuicksort $i >> "$FILENAME.txt";
    done ;
done

perl scripts/csv_quicksort_extractor2.pl < "$FILENAME.txt" > "${FILENAME}_wide.csv"