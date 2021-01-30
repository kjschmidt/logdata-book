my($category,$severity,$type,$srcip,$srcport,$dstip,$dstport) = $x =∼ /%(.*?)-(.*?)-(.*?):.* (.*?) \((.*?)\) -> (.*?) \((.*?)\) /g;
#
# or more generically
#
my($category,$severity,$type,$rest) = $x =∼ /%(.*?)-(.*?)-(.*?):(.*?)$/g;
