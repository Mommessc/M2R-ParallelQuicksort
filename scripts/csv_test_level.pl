
use strict;

my($line);
my($size);
my($time,$level);
print "Size, Time, T_Level\n" ;
while($line=<>) {
    chomp $line;
    if($line =~/^Size: ([\d\.]*)$/) {
        $size = $1;
        next;
    } 
    if($line =~/^Parallel quicksort.*: ([\d\.]*) sec with ([\d\.]*) T_LEVEL.$/) {
        print "$size, \"$1\", $2\n" ;
        next;
    } 
}
