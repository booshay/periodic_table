# /bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit
else
  ELEMENT=$($PSQL"SELECT * FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE atomic_number=$(($1)) OR symbol='$1' OR name='$1'")
  if [[ -z $ELEMENT ]]
  then
    echo "I could not find that element in the database."
  else
    echo $ELEMENT | while read TYPE_ID BAR AN BAR SYM BAR NAME BAR MASS BAR MELT BAR BOIL BAR TYPE
    do
    echo "The element with atomic number $AN is $NAME ($SYM). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
    done
  fi
fi

