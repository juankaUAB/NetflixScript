#!/bin/bash

function menu()
{
    clear
    echo "1.Recomanacio rapida"
    echo "2.Llistar per any"
    echo "3.LListar per rating"
    echo "4.Criteris de cerca"
    echo "5.Sortir"
}

function llegir_opcio()
{
  local opcio
    read -p "Escull una opcio (1-5): " opcio
    case $opcio in
     1)
        recomanacio_rapida
        sleep 3
        menu
         ;;

      2)
        llistar_per_any
        sleep 3
        menu
          ;;
      3)
         llistar_per_rating
         sleep 3
         menu
          ;;
      4)
        criteris_cerca
        sleep 3
        menu
         ;;
      5)
        exit 0
          ;;
      *)
         entrada_no_valida
         sleep 3
         menu
         ;;
esac
}
function recomanacio_rapida()
{


       echo "---------------------
Recomanació Rápida
---------------------"
   sort -R listado.txt | head -n1 > aleatori.txt
   echo `cut -d, -f1 aleatori.txt` "," `cut -d, -f5 aleatori.txt`
   cut -d, -f2 aleatori.txt
   cut -d, -f3 aleatori.txt
}

function llistar_per_any()
{

       echo "Introdueix un any: "
       read any
       cat listado.txt | sort | uniq > listado_rec1.txt
       grep  $any listado_rec1.txt > any.txt
       numfiles=`wc -l < any.txt`
       i=1
       while [  $i -lt $numfiles ]
       do
            fila1=`head -$i any.txt | tail -1 | cut -d, -f1`
            fila2=`head -$i any.txt | tail -1 | cut -d, -f2`
            echo $fila1 "," $fila2
            let i=i+1
       done

}

function llistar_per_rating ()
{
    cat listado.txt | sort | uniq > listado_rec.txt
    local estrella
    read -p "Escull un  rating (1-5): " estrella
    case $estrella in 

        1)
          rating_1
          rating_2
          rating_3
          rating_4
          rating_5
          sleep 3
          menu
          ;;
        2)
          rating_2
          rating_3
          rating_4
          rating_5
          sleep 3
          menu
          ;;
        3)
          rating_3
          rating_4
          rating_5
          sleep 3
          menu
          ;;
        4)
          rating_4
          rating_5
          sleep 3
          menu
          ;;
        5)
          rating_5
          sleep 3
          menu
          ;;
       *)
         entrada_no_valida
         sleep 3
         menu
          ;;

esac
}
function rating_1
{
awk -F"," '{ if ( $6 >= 0 && $6 < 65 ) print ; }' listado_rec.txt > listado_rat1.txt
numfilasrat1=`wc -l < listado_rat1.txt`
j=1
      while [ $j -lt $numfilasrat1 ]
      do
      nom=`head -$j listado_rat1.txt | tail -1 | cut -d, -f1`
      any1=`head -$j listado_rat1.txt | tail -1 | cut -d, -f5`
      echo "[  *  ] , " $nom "," $any1
      let j=j+1
      done
}

function rating_2
{
awk -F"," '{ if ( $6 >= 65 && $6 < 75 ) print ; }' listado_rec.txt > listado_rat2.txt
numfilasrat2=`wc -l < listado_rat2.txt`
k=1
      while [ $k -lt $numfilasrat2 ]
      do
      nom2=`head -$k listado_rat2.txt | tail -1 | cut -d, -f1`
      any2=`head -$k listado_rat2.txt | tail -1 | cut -d, -f5`
      echo "[  **  ] , " $nom2 "," $any2
      let k=k+1
      done

}

function rating_3
{
awk -F"," '{ if ( $6 >= 75 && $6 < 85 ) print ; }' listado_rec.txt > listado_rat3.txt
numfilasrat3=`wc -l < listado_rat3.txt`
l=1
      while [ $l -lt $numfilasrat3 ]
      do
      nom3=`head -$l listado_rat3.txt | tail -1 | cut -d, -f1`
      any3=`head -$l listado_rat3.txt | tail -1 | cut -d, -f5`
      echo "[  ***  ] , " $nom3 "," $any3
      let l=l+1
      done
}

function rating_4
{
awk -F"," '{ if ( $6 >= 85 && $6 < 95 ) print ; }' listado_rec.txt > listado_rat4.txt
numfilasrat4=`wc -l < listado_rat4.txt`
f=1
      while [ $f -lt $numfilasrat4 ]
      do
      nom4=`head -$f listado_rat4.txt | tail -1 | cut -d, -f1`
      any4=`head -$f listado_rat4.txt | tail -1 | cut -d, -f5`
      echo "[  ****  ] , " $nom4 "," $any4
      let f=f+1
      done
}

function rating_5
{
awk -F"," '{ if ( $6 >= 95 && $6 <= 100 ) print ; }' listado_rec.txt > listado_rat5.txt
numfilasrat5=`wc -l < listado_rat5.txt`
a=1
      while [ $a -lt $numfilasrat5 ]
      do
      nom5=`head -$a listado_rat5.txt | tail -1 | cut -d, -f1`
      any5=`head -$a listado_rat5.txt | tail -1 | cut -d, -f5`
      echo "[*****] , " $nom5 "," $any5
      let a=a+1
      done
}


function criteris_cerca
{
     menu_cerca
     echo " "
     echo "Escull (a-b):"
     read cerca
     case $cerca in
      a)
        modificar_preferencies
        sleep 3
        menu
         ;;
     b)
       eliminar_preferencies
       sleep 3
       menu
        ;;
     *)
       entrada_no_valida
       sleep 3
       menu
         ;;
esac
}

function modificar_preferencies
{
   read -p "Any: " any_cerca
   read -p "Rating: " rating_cerca
   read -p "Stars: " stars_cerca
   cat /dev/null > preferencies.txt
   echo $any_cerca >> preferencies.txt
   echo $rating_cerca >> preferencies.txt
   echo $stars_cerca >> preferencies.txt
}

function eliminar_preferencies
{
  cat /dev/null > preferencies.txt
}

function menu_cerca
{

  echo "a. Modificar Preferències."
  echo "b. Eliminar Preferències."
  echo " "
  echo "c. Preferències actuals:"
  echo " "
  echo "   Any: " `head -1 preferencies.txt`
  echo "   Rating: " `head -2 preferencies.txt | tail -1`
  echo "   Stars: " `head -3 preferencies.txt | tail -1`

}




function entrada_no_valida()
{

      echo -e $opcio "no es una entrada valida"
}

while true; do
menu
llegir_opcio
done



