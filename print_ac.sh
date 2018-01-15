if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit
fi
grep -Rho "[A-Z]\{2,5\}" $1 | sort | uniq
# grep -Rho "[A-Z]\{2,5\}" contents/kvs/*.tex | sort | uniq
