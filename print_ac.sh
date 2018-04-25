if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit
fi
grep -Rho "\b[A-Z]\{2,5\}\b" $1 | sort | uniq
# grep -Rho "[A-Z]\{2,5\}" contents/kvs/*.tex | sort | uniq
