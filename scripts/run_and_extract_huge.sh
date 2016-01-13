OUTPUT_DIRECTORY=data/`hostname`_`date +%F`
mkdir -p $OUTPUT_DIRECTORY
THREAD_LEVEL=$1
FILENAME="$OUTPUT_DIRECTORY/measurements_`date +%R`_thread$THREAD_LEVEL"



touch "$FILENAME.txt"
for i in 500000 1000000 2000000 4000000 6000000; do
	echo "Current size : $i";
    for rep in `seq 1 5`; do
        echo "Size: $i" >> "$FILENAME.txt";
        ./src/parallelQuicksort $i $THREAD_LEVEL >> "$FILENAME.txt";
    done ;
done

./scripts/test.sh $FILENAME