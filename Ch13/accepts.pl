# The script, accepts.pl, simply opens a data file and prints a single line from the file. 
# In order for this process to work properly, you must pre-process your log data, 
# much like we did in the previous section. MRTG is typically run periodically and 
# automatically via the UNIX cron facility. So you will want to have a script or 
# program pre-process your firewall data and dump out to a file the number of 
# occurrences of accepts. Here is an example accepts.pl:

#!/usr/bin/perl
 
open(FILE,”>processedFile”);
while($line = <FILE>) {
 chomp($line);
 print “$line\n”;
}

#
# The following code prints the system uptime and the hostname. These two
# items need to be included in every script that you write and should be the
# very last thing that is printed.
#

chomp($uptime = ‘/usr/bin/uptime’);
print “$uptime\n”;
chomp($hostname = ‘/bin/hostname’);
print “$hostname\n”;
