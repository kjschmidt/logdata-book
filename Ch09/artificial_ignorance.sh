#
# Source: Marcus Ranum
#
cd /var/log
cat * | \
sed -e ‘s/^.*demo//’ -e ‘s/\[[0–9]*\]//’ | \
sort | uniq -c | \
sort -r -n > /tmp/xx
