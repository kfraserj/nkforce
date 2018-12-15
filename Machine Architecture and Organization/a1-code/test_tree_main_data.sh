#!/bin/bash
T=0                             # global test number


((T++))
tnames[T]="start-print-quit"
read  -r -d '' input[$T] <<"ENDIN"
print
quit
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
BST Demo
Commands:
  print:          shows contents of the tree in sorted order
  show:           shows contents in pre-order indicating its structure
  clear:          eliminates all elements from the tree
  quit:           exit the program
  add <name>:     inserts the given string into the tree, duplicates ignored
  find <name>:    prints FOUND if the name is in the tree, NOT FOUND otherwise
  save <file>:    writes the contents of the tree in post order to the given file
  load <file>:    clears the current tree and loads the one in the given file
BST> print
BST> quit
ENDOUT


((T++))
tnames[T]="find-empty"
read  -r -d '' input[$T] <<"ENDIN"
print
find apple
find banana
quit
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
BST Demo
Commands:
  print:          shows contents of the tree in sorted order
  show:           shows contents in pre-order indicating its structure
  clear:          eliminates all elements from the tree
  quit:           exit the program
  add <name>:     inserts the given string into the tree, duplicates ignored
  find <name>:    prints FOUND if the name is in the tree, NOT FOUND otherwise
  save <file>:    writes the contents of the tree in post order to the given file
  load <file>:    clears the current tree and loads the one in the given file
BST> print
BST> find apple
NOT FOUND
BST> find banana
NOT FOUND
BST> quit
ENDOUT


((T++))
tnames[T]="find-single"
read  -r -d '' input[$T] <<"ENDIN"
print
add apple
find apple
find banana
quit
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
BST Demo
Commands:
  print:          shows contents of the tree in sorted order
  show:           shows contents in pre-order indicating its structure
  clear:          eliminates all elements from the tree
  quit:           exit the program
  add <name>:     inserts the given string into the tree, duplicates ignored
  find <name>:    prints FOUND if the name is in the tree, NOT FOUND otherwise
  save <file>:    writes the contents of the tree in post order to the given file
  load <file>:    clears the current tree and loads the one in the given file
BST> print
BST> add apple
BST> find apple
FOUND
BST> find banana
NOT FOUND
BST> quit
ENDOUT


((T++))
tnames[T]="add3"
read  -r -d '' input[$T] <<"ENDIN"
add Kyle
add Stan
add Cartman
print
show
find Kyle
find Kenny
find Stan
find Cartman
find Token
quit
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
BST Demo
Commands:
  print:          shows contents of the tree in sorted order
  show:           shows contents in pre-order indicating its structure
  clear:          eliminates all elements from the tree
  quit:           exit the program
  add <name>:     inserts the given string into the tree, duplicates ignored
  find <name>:    prints FOUND if the name is in the tree, NOT FOUND otherwise
  save <file>:    writes the contents of the tree in post order to the given file
  load <file>:    clears the current tree and loads the one in the given file
BST> add Kyle
BST> add Stan
BST> add Cartman
BST> print
Cartman
Kyle
Stan
BST> show
Kyle
 Cartman
 Stan
BST> find Kyle
FOUND
BST> find Kenny
NOT FOUND
BST> find Stan
FOUND
BST> find Cartman
FOUND
BST> find Token
NOT FOUND
BST> quit
ENDOUT

((T++))
tnames[T]="add3-reorder"
read  -r -d '' input[$T] <<"ENDIN"
add Stan
add Kyle
add Cartman
print
show
find Kyle
find Kenny
find Stan
find Cartman
find Token
quit
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
BST Demo
Commands:
  print:          shows contents of the tree in sorted order
  show:           shows contents in pre-order indicating its structure
  clear:          eliminates all elements from the tree
  quit:           exit the program
  add <name>:     inserts the given string into the tree, duplicates ignored
  find <name>:    prints FOUND if the name is in the tree, NOT FOUND otherwise
  save <file>:    writes the contents of the tree in post order to the given file
  load <file>:    clears the current tree and loads the one in the given file
BST> add Stan
BST> add Kyle
BST> add Cartman
BST> print
Cartman
Kyle
Stan
BST> show
Stan
 Kyle
  Cartman
BST> find Kyle
FOUND
BST> find Kenny
NOT FOUND
BST> find Stan
FOUND
BST> find Cartman
FOUND
BST> find Token
NOT FOUND
BST> quit
ENDOUT

((T++))
tnames[T]="add3-EOF"
read  -r -d '' input[$T] <<"ENDIN"
add Kyle
add Stan
add Cartman
print
show
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
BST Demo
Commands:
  print:          shows contents of the tree in sorted order
  show:           shows contents in pre-order indicating its structure
  clear:          eliminates all elements from the tree
  quit:           exit the program
  add <name>:     inserts the given string into the tree, duplicates ignored
  find <name>:    prints FOUND if the name is in the tree, NOT FOUND otherwise
  save <file>:    writes the contents of the tree in post order to the given file
  load <file>:    clears the current tree and loads the one in the given file
BST> add Kyle
BST> add Stan
BST> add Cartman
BST> print
Cartman
Kyle
Stan
BST> show
Kyle
 Cartman
 Stan
BST> 
ENDOUT


((T++))
tnames[T]="add-lots"
read  -r -d '' input[$T] <<"ENDIN"
add Kyle
add Stan
add Cartman
find Kenny
find Stan
print
show
add Kenny
add Butters
add Token
add Wendy
add MrGarrison
find Kenny
find Wendy
find Cartman
find MrHat
find MrStick
print
show
add MrHat
add MrStick
print
show
quit
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
BST Demo
Commands:
  print:          shows contents of the tree in sorted order
  show:           shows contents in pre-order indicating its structure
  clear:          eliminates all elements from the tree
  quit:           exit the program
  add <name>:     inserts the given string into the tree, duplicates ignored
  find <name>:    prints FOUND if the name is in the tree, NOT FOUND otherwise
  save <file>:    writes the contents of the tree in post order to the given file
  load <file>:    clears the current tree and loads the one in the given file
BST> add Kyle
BST> add Stan
BST> add Cartman
BST> find Kenny
NOT FOUND
BST> find Stan
FOUND
BST> print
Cartman
Kyle
Stan
BST> show
Kyle
 Cartman
 Stan
BST> add Kenny
BST> add Butters
BST> add Token
BST> add Wendy
BST> add MrGarrison
BST> find Kenny
FOUND
BST> find Wendy
FOUND
BST> find Cartman
FOUND
BST> find MrHat
NOT FOUND
BST> find MrStick
NOT FOUND
BST> print
Butters
Cartman
Kenny
Kyle
MrGarrison
Stan
Token
Wendy
BST> show
Kyle
 Cartman
  Butters
  Kenny
 Stan
  MrGarrison
  Token
   Wendy
BST> add MrHat
BST> add MrStick
BST> print
Butters
Cartman
Kenny
Kyle
MrGarrison
MrHat
MrStick
Stan
Token
Wendy
BST> show
Kyle
 Cartman
  Butters
  Kenny
 Stan
  MrGarrison
   MrHat
    MrStick
  Token
   Wendy
BST> quit
ENDOUT



((T++))
tnames[T]="add-clear-add"
read  -r -d '' input[$T] <<"ENDIN"
add Kyle
add Stan
add Cartman
clear
add Kenny
add Butters
add Token
add Wendy
add MrGarrison
print
show
clear
print
show
quit
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
BST Demo
Commands:
  print:          shows contents of the tree in sorted order
  show:           shows contents in pre-order indicating its structure
  clear:          eliminates all elements from the tree
  quit:           exit the program
  add <name>:     inserts the given string into the tree, duplicates ignored
  find <name>:    prints FOUND if the name is in the tree, NOT FOUND otherwise
  save <file>:    writes the contents of the tree in post order to the given file
  load <file>:    clears the current tree and loads the one in the given file
BST> add Kyle
BST> add Stan
BST> add Cartman
BST> clear
BST> add Kenny
BST> add Butters
BST> add Token
BST> add Wendy
BST> add MrGarrison
BST> print
Butters
Kenny
MrGarrison
Token
Wendy
BST> show
Kenny
 Butters
 Token
  MrGarrison
  Wendy
BST> clear
BST> print
BST> show
BST> quit
ENDOUT


((T++))
tnames[T]="many-clears"
read  -r -d '' input[$T] <<"ENDIN"
add Kyle
add Stan
add Cartman
print
clear
add Kenny
add Butters
print
clear
add Token
add Wendy
add MrGarrison
show
clear
show
add MrHat
add MrStick
add Kenny
add CloneStan
print 
clear
quit
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
BST Demo
Commands:
  print:          shows contents of the tree in sorted order
  show:           shows contents in pre-order indicating its structure
  clear:          eliminates all elements from the tree
  quit:           exit the program
  add <name>:     inserts the given string into the tree, duplicates ignored
  find <name>:    prints FOUND if the name is in the tree, NOT FOUND otherwise
  save <file>:    writes the contents of the tree in post order to the given file
  load <file>:    clears the current tree and loads the one in the given file
BST> add Kyle
BST> add Stan
BST> add Cartman
BST> print
Cartman
Kyle
Stan
BST> clear
BST> add Kenny
BST> add Butters
BST> print
Butters
Kenny
BST> clear
BST> add Token
BST> add Wendy
BST> add MrGarrison
BST> show
Token
 MrGarrison
 Wendy
BST> clear
BST> show
BST> add MrHat
BST> add MrStick
BST> add Kenny
BST> add CloneStan
BST> print
CloneStan
Kenny
MrHat
MrStick
BST> clear
BST> quit
ENDOUT


((T++))
tnames[T]="add1-save"
read  -r -d '' input[$T] <<"ENDIN"
add hello
save test-data/x.tree
quit
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
BST Demo
Commands:
  print:          shows contents of the tree in sorted order
  show:           shows contents in pre-order indicating its structure
  clear:          eliminates all elements from the tree
  quit:           exit the program
  add <name>:     inserts the given string into the tree, duplicates ignored
  find <name>:    prints FOUND if the name is in the tree, NOT FOUND otherwise
  save <file>:    writes the contents of the tree in post order to the given file
  load <file>:    clears the current tree and loads the one in the given file
BST> add hello
BST> save test-data/x.tree
BST> quit
ENDOUT
#
tfiles[T]="test-data/x.tree"
read  -r -d '' tfiles_expect[$T] <<"ENDOUT"
hello
ENDOUT



((T++))
tnames[T]="add3-save"
read  -r -d '' input[$T] <<"ENDIN"
add Kyle
add Stan
add Cartman
save test-data/sp3.tree
quit
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
BST Demo
Commands:
  print:          shows contents of the tree in sorted order
  show:           shows contents in pre-order indicating its structure
  clear:          eliminates all elements from the tree
  quit:           exit the program
  add <name>:     inserts the given string into the tree, duplicates ignored
  find <name>:    prints FOUND if the name is in the tree, NOT FOUND otherwise
  save <file>:    writes the contents of the tree in post order to the given file
  load <file>:    clears the current tree and loads the one in the given file
BST> add Kyle
BST> add Stan
BST> add Cartman
BST> save test-data/sp3.tree
BST> quit
ENDOUT
#
tfiles[T]="test-data/sp3.tree"
read  -r -d '' tfiles_expect[$T] <<"ENDOUT"
Kyle
 Cartman
 Stan
ENDOUT


((T++))
tnames[T]="save-load"
read  -r -d '' input[$T] <<"ENDIN"
add Kyle
add Stan
add Cartman
add MrGarrison
save test-data/sp4.tree
clear
show
load test-data/sp4.tree
print 
show
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
BST Demo
Commands:
  print:          shows contents of the tree in sorted order
  show:           shows contents in pre-order indicating its structure
  clear:          eliminates all elements from the tree
  quit:           exit the program
  add <name>:     inserts the given string into the tree, duplicates ignored
  find <name>:    prints FOUND if the name is in the tree, NOT FOUND otherwise
  save <file>:    writes the contents of the tree in post order to the given file
  load <file>:    clears the current tree and loads the one in the given file
BST> add Kyle
BST> add Stan
BST> add Cartman
BST> add MrGarrison
BST> save test-data/sp4.tree
BST> clear
BST> show
BST> load test-data/sp4.tree
BST> print
Cartman
Kyle
MrGarrison
Stan
BST> show
Kyle
 Cartman
 Stan
  MrGarrison
BST> 
ENDOUT
#
tfiles[T]="test-data/sp4.tree"
read  -r -d '' tfiles_expect[$T] <<"ENDOUT"
Kyle
 Cartman
 Stan
  MrGarrison
ENDOUT

# ((T++))
# tnames[T]="load-fails"
# read  -r -d '' input[$T] <<"ENDIN"
# ENDIN
# #
# read  -r -d '' output[$T] <<"ENDOUT"
# ENDOUT
# #
# tfiles[T]="test-data/sp4.tree"
# read  -r -d '' tfiles_expect[$T] <<"ENDOUT"
# ENDOUT

((T++))
tnames[T]="multiple-saves"
read  -r -d '' input[$T] <<"ENDIN"
add Kyle
add Stan
add Cartman
add MrGarrison
add Kenny
save test-data/sp5.tree
add Wendy
add Token
add Butters
save test-data/sp8.tree
load test-data/sp5.tree
print 
show
load test-data/sp8.tree
print 
show
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
BST Demo
Commands:
  print:          shows contents of the tree in sorted order
  show:           shows contents in pre-order indicating its structure
  clear:          eliminates all elements from the tree
  quit:           exit the program
  add <name>:     inserts the given string into the tree, duplicates ignored
  find <name>:    prints FOUND if the name is in the tree, NOT FOUND otherwise
  save <file>:    writes the contents of the tree in post order to the given file
  load <file>:    clears the current tree and loads the one in the given file
BST> add Kyle
BST> add Stan
BST> add Cartman
BST> add MrGarrison
BST> add Kenny
BST> save test-data/sp5.tree
BST> add Wendy
BST> add Token
BST> add Butters
BST> save test-data/sp8.tree
BST> load test-data/sp5.tree
BST> print
Cartman
Kenny
Kyle
MrGarrison
Stan
BST> show
Kyle
 Cartman
  Kenny
 Stan
  MrGarrison
BST> load test-data/sp8.tree
BST> print
Butters
Cartman
Kenny
Kyle
MrGarrison
Stan
Token
Wendy
BST> show
Kyle
 Cartman
  Butters
  Kenny
 Stan
  MrGarrison
  Wendy
   Token
BST> 
ENDOUT
#
tfiles[T]="test-data/sp8.tree"
read  -r -d '' tfiles_expect[$T] <<"ENDOUT"
Kyle
 Cartman
  Butters
  Kenny
 Stan
  MrGarrison
  Wendy
   Token
ENDOUT



((T++))
tnames[T]="stranger-demo"
read  -r -d '' input[$T] <<"ENDIN"
add Lucas
add Mike
add Dustin
add Will
add El
print 
show 
find Mike
find Nancy
add Nancy
show 
find Max
add Max
show 
print 
find Barb
add Barb
show 
save test-data/stranger.tree
clear 
print 
add Demigorgon
show 
load test-data/stranger.tree
show 
add Jim
add Joyce
show 
load test-data/stranger.tree
show 
quit 
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
BST Demo
Commands:
  print:          shows contents of the tree in sorted order
  show:           shows contents in pre-order indicating its structure
  clear:          eliminates all elements from the tree
  quit:           exit the program
  add <name>:     inserts the given string into the tree, duplicates ignored
  find <name>:    prints FOUND if the name is in the tree, NOT FOUND otherwise
  save <file>:    writes the contents of the tree in post order to the given file
  load <file>:    clears the current tree and loads the one in the given file
BST> add Lucas
BST> add Mike
BST> add Dustin
BST> add Will
BST> add El
BST> print
Dustin
El
Lucas
Mike
Will
BST> show
Lucas
 Dustin
  El
 Mike
  Will
BST> find Mike
FOUND
BST> find Nancy
NOT FOUND
BST> add Nancy
BST> show
Lucas
 Dustin
  El
 Mike
  Will
   Nancy
BST> find Max
NOT FOUND
BST> add Max
BST> show
Lucas
 Dustin
  El
 Mike
  Max
  Will
   Nancy
BST> print
Dustin
El
Lucas
Max
Mike
Nancy
Will
BST> find Barb
NOT FOUND
BST> add Barb
BST> show
Lucas
 Dustin
  Barb
  El
 Mike
  Max
  Will
   Nancy
BST> save test-data/stranger.tree
BST> clear
BST> print
BST> add Demigorgon
BST> show
Demigorgon
BST> load test-data/stranger.tree
BST> show
Lucas
 Dustin
  Barb
  El
 Mike
  Max
  Will
   Nancy
BST> add Jim
BST> add Joyce
BST> show
Lucas
 Dustin
  Barb
  El
   Jim
    Joyce
 Mike
  Max
  Will
   Nancy
BST> load test-data/stranger.tree
BST> show
Lucas
 Dustin
  Barb
  El
 Mike
  Max
  Will
   Nancy
BST> quit
ENDOUT
#
tfiles[T]="test-data/stranger.tree"
read  -r -d '' tfiles_expect[$T] <<"ENDOUT"
Lucas
 Dustin
  Barb
  El
 Mike
  Max
  Will
   Nancy
ENDOUT


((T++))
tnames[T]="big-stress"
read  -r -d '' input[$T] <<"ENDIN"
add Mary
add James
add Elizabeth
add Barbara
add Anthony
add Andrew
add Amanda
add Alexander
add Aaron
add Adam
add Abigail
add Albert
add Alan
add Alice
add Alexis
add Amy
add Amber
add Andrea
add Anna
add Angela
add Ann
add Ashley
add Arthur
add Austin
add David
add Charles
add Betty
add Benjamin
add Carol
add Brian
add Brenda
add Brandon
add Billy
add Beverly
add Bobby
add Carl
add Bryan
add Bruce
add Brittany
add Catherine
add Carolyn
add Christopher
add Christine
add Christina
add Cheryl
add Christian
add Daniel
add Cynthia
add Danielle
add Dorothy
print
show
add Donald
add Deborah
add Debra
add Dennis
add Denise
add Diane
add Diana
add Donna
add Doris
add Edward
add Douglas
add Dylan
add George
add Emily
add Gary
add Eric
add Emma
add Frank
add Evelyn
add Ethan
add Eugene
add Frances
add Gabriel
add Helen
add Gregory
add Gerald
add Gloria
add Grace
add Heather
add Harold
add Hannah
add Harry
add Jacob
add Jack
add Henry
add Jacqueline
add John
add Jennifer
add Jason
add Janet
add Jane
add Janice
add Jeffrey
add Jean
add Jessica
add Jerry
add Jeremy
add Jesse
add Joan
print show
add Joe
add Linda
add Joseph
add Jonathan
add Johnny
add Jose
add Jordan
add Karen
add Joshua
add Justin
add Julie
add Joyce
add Judith
add Juan
add Julia
add Judy
add Kimberly
add Kenneth
add Kathleen
add Katherine
add Kelly
add Keith
add Kathryn
add Kayla
add Kevin
add Laura
add Larry
add Kyle
add Lauren
add Lawrence
add Margaret
add Lisa
add Madison
add Louis
add Lori
add Logan
add Mark
add Maria
add Marie
add Marilyn
add Martha
add Patricia
add Michael
add Matthew
add Melissa
add Megan
add Nancy
add Michelle
add Nicholas
add Nathan
add Natalie
add Pamela
add Nicole
add Olivia
add Noah
add Robert
add Richard
add Paul
add Patrick
add Rebecca
add Raymond
add Rachel
add Peter
add Philip
add Ralph
add Randy
add William
add Susan
add Sarah
add Sandra
add Ronald
add Roger
add Ryan
add Ruth
add Roy
add Rose
add Russell
add Samantha
add Samuel
add Sara
add Steven
add Stephanie
add Sharon
add Scott
add Sean
add Shirley
add Stephen
add Thomas
add Terry
add Teresa
add Theresa
add Timothy
add Tiffany
add Virginia
add Tyler
add Victoria
add Vincent
add Walter
add Wayne
add Zachary
add Willie
print
show
find Steven
find Barbara
find Anakin
find Leia
find Luke
find Virginia
save test-data/big.tree
clear
add Sandra
add Ronald
add Roger
add Ryan
add Ruth
add Roy
add Rose
add Russell
add Samantha
add Samuel
add Sara
add Steven
add Stephanie
add Sharon
add Scott
add Sean
add Shirley
add Stephen
add Thomas
add Terry
add Teresa
add Theresa
add Timothy
add Tiffany
add Virginia
add Tyler
add Victoria
add Vincent
add Walter
add Wayne
add Zachary
add Willie
find Sara
find Virginia
find Anna
find Kevin
load test-data/big.tree
print 
show
find Sara
find Virginia
find Anna
find Kevin
ENDIN
#
read  -r -d '' output[$T] <<"ENDOUT"
BST Demo
Commands:
  print:          shows contents of the tree in sorted order
  show:           shows contents in pre-order indicating its structure
  clear:          eliminates all elements from the tree
  quit:           exit the program
  add <name>:     inserts the given string into the tree, duplicates ignored
  find <name>:    prints FOUND if the name is in the tree, NOT FOUND otherwise
  save <file>:    writes the contents of the tree in post order to the given file
  load <file>:    clears the current tree and loads the one in the given file
BST> add Mary
BST> add James
BST> add Elizabeth
BST> add Barbara
BST> add Anthony
BST> add Andrew
BST> add Amanda
BST> add Alexander
BST> add Aaron
BST> add Adam
BST> add Abigail
BST> add Albert
BST> add Alan
BST> add Alice
BST> add Alexis
BST> add Amy
BST> add Amber
BST> add Andrea
BST> add Anna
BST> add Angela
BST> add Ann
BST> add Ashley
BST> add Arthur
BST> add Austin
BST> add David
BST> add Charles
BST> add Betty
BST> add Benjamin
BST> add Carol
BST> add Brian
BST> add Brenda
BST> add Brandon
BST> add Billy
BST> add Beverly
BST> add Bobby
BST> add Carl
BST> add Bryan
BST> add Bruce
BST> add Brittany
BST> add Catherine
BST> add Carolyn
BST> add Christopher
BST> add Christine
BST> add Christina
BST> add Cheryl
BST> add Christian
BST> add Daniel
BST> add Cynthia
BST> add Danielle
BST> add Dorothy
BST> print
Aaron
Abigail
Adam
Alan
Albert
Alexander
Alexis
Alice
Amanda
Amber
Amy
Andrea
Andrew
Angela
Ann
Anna
Anthony
Arthur
Ashley
Austin
Barbara
Benjamin
Betty
Beverly
Billy
Bobby
Brandon
Brenda
Brian
Brittany
Bruce
Bryan
Carl
Carol
Carolyn
Catherine
Charles
Cheryl
Christian
Christina
Christine
Christopher
Cynthia
Daniel
Danielle
David
Dorothy
Elizabeth
James
Mary
BST> show
Mary
 James
  Elizabeth
   Barbara
    Anthony
     Andrew
      Amanda
       Alexander
        Aaron
         Adam
          Abigail
          Albert
           Alan
        Alice
         Alexis
       Amy
        Amber
        Andrea
      Anna
       Angela
        Ann
     Ashley
      Arthur
      Austin
    David
     Charles
      Betty
       Benjamin
       Carol
        Brian
         Brenda
          Brandon
           Billy
            Beverly
            Bobby
         Carl
          Bryan
           Bruce
            Brittany
        Catherine
         Carolyn
      Christopher
       Christine
        Christina
         Cheryl
          Christian
       Daniel
        Cynthia
        Danielle
     Dorothy
BST> add Donald
BST> add Deborah
BST> add Debra
BST> add Dennis
BST> add Denise
BST> add Diane
BST> add Diana
BST> add Donna
BST> add Doris
BST> add Edward
BST> add Douglas
BST> add Dylan
BST> add George
BST> add Emily
BST> add Gary
BST> add Eric
BST> add Emma
BST> add Frank
BST> add Evelyn
BST> add Ethan
BST> add Eugene
BST> add Frances
BST> add Gabriel
BST> add Helen
BST> add Gregory
BST> add Gerald
BST> add Gloria
BST> add Grace
BST> add Heather
BST> add Harold
BST> add Hannah
BST> add Harry
BST> add Jacob
BST> add Jack
BST> add Henry
BST> add Jacqueline
BST> add John
BST> add Jennifer
BST> add Jason
BST> add Janet
BST> add Jane
BST> add Janice
BST> add Jeffrey
BST> add Jean
BST> add Jessica
BST> add Jerry
BST> add Jeremy
BST> add Jesse
BST> add Joan
BST> print
Aaron
Abigail
Adam
Alan
Albert
Alexander
Alexis
Alice
Amanda
Amber
Amy
Andrea
Andrew
Angela
Ann
Anna
Anthony
Arthur
Ashley
Austin
Barbara
Benjamin
Betty
Beverly
Billy
Bobby
Brandon
Brenda
Brian
Brittany
Bruce
Bryan
Carl
Carol
Carolyn
Catherine
Charles
Cheryl
Christian
Christina
Christine
Christopher
Cynthia
Daniel
Danielle
David
Deborah
Debra
Denise
Dennis
Diana
Diane
Donald
Donna
Doris
Dorothy
Douglas
Dylan
Edward
Elizabeth
Emily
Emma
Eric
Ethan
Eugene
Evelyn
Frances
Frank
Gabriel
Gary
George
Gerald
Gloria
Grace
Gregory
Hannah
Harold
Harry
Heather
Helen
Henry
Jack
Jacob
Jacqueline
James
Jane
Janet
Janice
Jason
Jean
Jeffrey
Jennifer
Jeremy
Jerry
Jesse
Jessica
Joan
John
Mary
BST> show
Mary
 James
  Elizabeth
   Barbara
    Anthony
     Andrew
      Amanda
       Alexander
        Aaron
         Adam
          Abigail
          Albert
           Alan
        Alice
         Alexis
       Amy
        Amber
        Andrea
      Anna
       Angela
        Ann
     Ashley
      Arthur
      Austin
    David
     Charles
      Betty
       Benjamin
       Carol
        Brian
         Brenda
          Brandon
           Billy
            Beverly
            Bobby
         Carl
          Bryan
           Bruce
            Brittany
        Catherine
         Carolyn
      Christopher
       Christine
        Christina
         Cheryl
          Christian
       Daniel
        Cynthia
        Danielle
     Dorothy
      Donald
       Deborah
        Debra
         Dennis
          Denise
          Diane
           Diana
       Donna
        Doris
      Edward
       Douglas
        Dylan
   George
    Emily
     Gary
      Eric
       Emma
       Frank
        Evelyn
         Ethan
          Eugene
         Frances
        Gabriel
    Helen
     Gregory
      Gerald
       Gloria
        Grace
      Heather
       Harold
        Hannah
        Harry
     Jacob
      Jack
       Henry
      Jacqueline
  John
   Jennifer
    Jason
     Janet
      Jane
      Janice
     Jeffrey
      Jean
    Jessica
     Jerry
      Jeremy
      Jesse
     Joan
BST> add Joe
BST> add Linda
BST> add Joseph
BST> add Jonathan
BST> add Johnny
BST> add Jose
BST> add Jordan
BST> add Karen
BST> add Joshua
BST> add Justin
BST> add Julie
BST> add Joyce
BST> add Judith
BST> add Juan
BST> add Julia
BST> add Judy
BST> add Kimberly
BST> add Kenneth
BST> add Kathleen
BST> add Katherine
BST> add Kelly
BST> add Keith
BST> add Kathryn
BST> add Kayla
BST> add Kevin
BST> add Laura
BST> add Larry
BST> add Kyle
BST> add Lauren
BST> add Lawrence
BST> add Margaret
BST> add Lisa
BST> add Madison
BST> add Louis
BST> add Lori
BST> add Logan
BST> add Mark
BST> add Maria
BST> add Marie
BST> add Marilyn
BST> add Martha
BST> add Patricia
BST> add Michael
BST> add Matthew
BST> add Melissa
BST> add Megan
BST> add Nancy
BST> add Michelle
BST> add Nicholas
BST> add Nathan
BST> add Natalie
BST> add Pamela
BST> add Nicole
BST> add Olivia
BST> add Noah
BST> add Robert
BST> add Richard
BST> add Paul
BST> add Patrick
BST> add Rebecca
BST> add Raymond
BST> add Rachel
BST> add Peter
BST> add Philip
BST> add Ralph
BST> add Randy
BST> add William
BST> add Susan
BST> add Sarah
BST> add Sandra
BST> add Ronald
BST> add Roger
BST> add Ryan
BST> add Ruth
BST> add Roy
BST> add Rose
BST> add Russell
BST> add Samantha
BST> add Samuel
BST> add Sara
BST> add Steven
BST> add Stephanie
BST> add Sharon
BST> add Scott
BST> add Sean
BST> add Shirley
BST> add Stephen
BST> add Thomas
BST> add Terry
BST> add Teresa
BST> add Theresa
BST> add Timothy
BST> add Tiffany
BST> add Virginia
BST> add Tyler
BST> add Victoria
BST> add Vincent
BST> add Walter
BST> add Wayne
BST> add Zachary
BST> add Willie
BST> print
Aaron
Abigail
Adam
Alan
Albert
Alexander
Alexis
Alice
Amanda
Amber
Amy
Andrea
Andrew
Angela
Ann
Anna
Anthony
Arthur
Ashley
Austin
Barbara
Benjamin
Betty
Beverly
Billy
Bobby
Brandon
Brenda
Brian
Brittany
Bruce
Bryan
Carl
Carol
Carolyn
Catherine
Charles
Cheryl
Christian
Christina
Christine
Christopher
Cynthia
Daniel
Danielle
David
Deborah
Debra
Denise
Dennis
Diana
Diane
Donald
Donna
Doris
Dorothy
Douglas
Dylan
Edward
Elizabeth
Emily
Emma
Eric
Ethan
Eugene
Evelyn
Frances
Frank
Gabriel
Gary
George
Gerald
Gloria
Grace
Gregory
Hannah
Harold
Harry
Heather
Helen
Henry
Jack
Jacob
Jacqueline
James
Jane
Janet
Janice
Jason
Jean
Jeffrey
Jennifer
Jeremy
Jerry
Jesse
Jessica
Joan
Joe
John
Johnny
Jonathan
Jordan
Jose
Joseph
Joshua
Joyce
Juan
Judith
Judy
Julia
Julie
Justin
Karen
Katherine
Kathleen
Kathryn
Kayla
Keith
Kelly
Kenneth
Kevin
Kimberly
Kyle
Larry
Laura
Lauren
Lawrence
Linda
Lisa
Logan
Lori
Louis
Madison
Margaret
Maria
Marie
Marilyn
Mark
Martha
Mary
Matthew
Megan
Melissa
Michael
Michelle
Nancy
Natalie
Nathan
Nicholas
Nicole
Noah
Olivia
Pamela
Patricia
Patrick
Paul
Peter
Philip
Rachel
Ralph
Randy
Raymond
Rebecca
Richard
Robert
Roger
Ronald
Rose
Roy
Russell
Ruth
Ryan
Samantha
Samuel
Sandra
Sara
Sarah
Scott
Sean
Sharon
Shirley
Stephanie
Stephen
Steven
Susan
Teresa
Terry
Theresa
Thomas
Tiffany
Timothy
Tyler
Victoria
Vincent
Virginia
Walter
Wayne
William
Willie
Zachary
BST> show
Mary
 James
  Elizabeth
   Barbara
    Anthony
     Andrew
      Amanda
       Alexander
        Aaron
         Adam
          Abigail
          Albert
           Alan
        Alice
         Alexis
       Amy
        Amber
        Andrea
      Anna
       Angela
        Ann
     Ashley
      Arthur
      Austin
    David
     Charles
      Betty
       Benjamin
       Carol
        Brian
         Brenda
          Brandon
           Billy
            Beverly
            Bobby
         Carl
          Bryan
           Bruce
            Brittany
        Catherine
         Carolyn
      Christopher
       Christine
        Christina
         Cheryl
          Christian
       Daniel
        Cynthia
        Danielle
     Dorothy
      Donald
       Deborah
        Debra
         Dennis
          Denise
          Diane
           Diana
       Donna
        Doris
      Edward
       Douglas
        Dylan
   George
    Emily
     Gary
      Eric
       Emma
       Frank
        Evelyn
         Ethan
          Eugene
         Frances
        Gabriel
    Helen
     Gregory
      Gerald
       Gloria
        Grace
      Heather
       Harold
        Hannah
        Harry
     Jacob
      Jack
       Henry
      Jacqueline
  John
   Jennifer
    Jason
     Janet
      Jane
      Janice
     Jeffrey
      Jean
    Jessica
     Jerry
      Jeremy
      Jesse
     Joan
      Joe
   Linda
    Joseph
     Jonathan
      Johnny
      Jose
       Jordan
     Karen
      Joshua
       Justin
        Julie
         Joyce
          Judith
           Juan
           Julia
            Judy
      Kimberly
       Kenneth
        Kathleen
         Katherine
         Kelly
          Keith
           Kathryn
            Kayla
        Kevin
       Laura
        Larry
         Kyle
        Lauren
         Lawrence
    Margaret
     Lisa
      Madison
       Louis
        Lori
         Logan
     Mark
      Maria
       Marie
        Marilyn
      Martha
 Patricia
  Michael
   Matthew
    Melissa
     Megan
   Nancy
    Michelle
    Nicholas
     Nathan
      Natalie
     Pamela
      Nicole
       Olivia
        Noah
  Robert
   Richard
    Paul
     Patrick
     Rebecca
      Raymond
       Rachel
        Peter
         Philip
        Ralph
         Randy
   William
    Susan
     Sarah
      Sandra
       Ronald
        Roger
        Ryan
         Ruth
          Roy
           Rose
           Russell
         Samantha
          Samuel
       Sara
      Steven
       Stephanie
        Sharon
         Scott
          Sean
         Shirley
        Stephen
     Thomas
      Terry
       Teresa
       Theresa
      Timothy
       Tiffany
       Virginia
        Tyler
         Victoria
          Vincent
        Walter
         Wayne
    Zachary
     Willie
BST> find Steven
FOUND
BST> find Barbara
FOUND
BST> find Anakin
NOT FOUND
BST> find Leia
NOT FOUND
BST> find Luke
NOT FOUND
BST> find Virginia
FOUND
BST> save test-data/big.tree
BST> clear
BST> add Sandra
BST> add Ronald
BST> add Roger
BST> add Ryan
BST> add Ruth
BST> add Roy
BST> add Rose
BST> add Russell
BST> add Samantha
BST> add Samuel
BST> add Sara
BST> add Steven
BST> add Stephanie
BST> add Sharon
BST> add Scott
BST> add Sean
BST> add Shirley
BST> add Stephen
BST> add Thomas
BST> add Terry
BST> add Teresa
BST> add Theresa
BST> add Timothy
BST> add Tiffany
BST> add Virginia
BST> add Tyler
BST> add Victoria
BST> add Vincent
BST> add Walter
BST> add Wayne
BST> add Zachary
BST> add Willie
BST> find Sara
FOUND
BST> find Virginia
FOUND
BST> find Anna
NOT FOUND
BST> find Kevin
NOT FOUND
BST> load test-data/big.tree
BST> print
Aaron
Abigail
Adam
Alan
Albert
Alexander
Alexis
Alice
Amanda
Amber
Amy
Andrea
Andrew
Angela
Ann
Anna
Anthony
Arthur
Ashley
Austin
Barbara
Benjamin
Betty
Beverly
Billy
Bobby
Brandon
Brenda
Brian
Brittany
Bruce
Bryan
Carl
Carol
Carolyn
Catherine
Charles
Cheryl
Christian
Christina
Christine
Christopher
Cynthia
Daniel
Danielle
David
Deborah
Debra
Denise
Dennis
Diana
Diane
Donald
Donna
Doris
Dorothy
Douglas
Dylan
Edward
Elizabeth
Emily
Emma
Eric
Ethan
Eugene
Evelyn
Frances
Frank
Gabriel
Gary
George
Gerald
Gloria
Grace
Gregory
Hannah
Harold
Harry
Heather
Helen
Henry
Jack
Jacob
Jacqueline
James
Jane
Janet
Janice
Jason
Jean
Jeffrey
Jennifer
Jeremy
Jerry
Jesse
Jessica
Joan
Joe
John
Johnny
Jonathan
Jordan
Jose
Joseph
Joshua
Joyce
Juan
Judith
Judy
Julia
Julie
Justin
Karen
Katherine
Kathleen
Kathryn
Kayla
Keith
Kelly
Kenneth
Kevin
Kimberly
Kyle
Larry
Laura
Lauren
Lawrence
Linda
Lisa
Logan
Lori
Louis
Madison
Margaret
Maria
Marie
Marilyn
Mark
Martha
Mary
Matthew
Megan
Melissa
Michael
Michelle
Nancy
Natalie
Nathan
Nicholas
Nicole
Noah
Olivia
Pamela
Patricia
Patrick
Paul
Peter
Philip
Rachel
Ralph
Randy
Raymond
Rebecca
Richard
Robert
Roger
Ronald
Rose
Roy
Russell
Ruth
Ryan
Samantha
Samuel
Sandra
Sara
Sarah
Scott
Sean
Sharon
Shirley
Stephanie
Stephen
Steven
Susan
Teresa
Terry
Theresa
Thomas
Tiffany
Timothy
Tyler
Victoria
Vincent
Virginia
Walter
Wayne
William
Willie
Zachary
BST> show
Mary
 James
  Elizabeth
   Barbara
    Anthony
     Andrew
      Amanda
       Alexander
        Aaron
         Adam
          Abigail
          Albert
           Alan
        Alice
         Alexis
       Amy
        Amber
        Andrea
      Anna
       Angela
        Ann
     Ashley
      Arthur
      Austin
    David
     Charles
      Betty
       Benjamin
       Carol
        Brian
         Brenda
          Brandon
           Billy
            Beverly
            Bobby
         Carl
          Bryan
           Bruce
            Brittany
        Catherine
         Carolyn
      Christopher
       Christine
        Christina
         Cheryl
          Christian
       Daniel
        Cynthia
        Danielle
     Dorothy
      Donald
       Deborah
        Debra
         Dennis
          Denise
          Diane
           Diana
       Donna
        Doris
      Edward
       Douglas
        Dylan
   George
    Emily
     Gary
      Eric
       Emma
       Frank
        Evelyn
         Ethan
          Eugene
         Frances
        Gabriel
    Helen
     Gregory
      Gerald
       Gloria
        Grace
      Heather
       Harold
        Hannah
        Harry
     Jacob
      Jack
       Henry
      Jacqueline
  John
   Jennifer
    Jason
     Janet
      Jane
      Janice
     Jeffrey
      Jean
    Jessica
     Jerry
      Jeremy
      Jesse
     Joan
      Joe
   Linda
    Joseph
     Jonathan
      Johnny
      Jose
       Jordan
     Karen
      Joshua
       Justin
        Julie
         Joyce
          Judith
           Juan
           Julia
            Judy
      Kimberly
       Kenneth
        Kathleen
         Katherine
         Kelly
          Keith
           Kathryn
            Kayla
        Kevin
       Laura
        Larry
         Kyle
        Lauren
         Lawrence
    Margaret
     Lisa
      Madison
       Louis
        Lori
         Logan
     Mark
      Maria
       Marie
        Marilyn
      Martha
 Patricia
  Michael
   Matthew
    Melissa
     Megan
   Nancy
    Michelle
    Nicholas
     Nathan
      Natalie
     Pamela
      Nicole
       Olivia
        Noah
  Robert
   Richard
    Paul
     Patrick
     Rebecca
      Raymond
       Rachel
        Peter
         Philip
        Ralph
         Randy
   William
    Susan
     Sarah
      Sandra
       Ronald
        Roger
        Ryan
         Ruth
          Roy
           Rose
           Russell
         Samantha
          Samuel
       Sara
      Steven
       Stephanie
        Sharon
         Scott
          Sean
         Shirley
        Stephen
     Thomas
      Terry
       Teresa
       Theresa
      Timothy
       Tiffany
       Virginia
        Tyler
         Victoria
          Vincent
        Walter
         Wayne
    Zachary
     Willie
BST> find Sara
FOUND
BST> find Virginia
FOUND
BST> find Anna
FOUND
BST> find Kevin
FOUND
BST> 
ENDOUT
#
tfiles[T]="test-data/big.tree"
read  -r -d '' tfiles_expect[$T] <<"ENDOUT"
Mary
 James
  Elizabeth
   Barbara
    Anthony
     Andrew
      Amanda
       Alexander
        Aaron
         Adam
          Abigail
          Albert
           Alan
        Alice
         Alexis
       Amy
        Amber
        Andrea
      Anna
       Angela
        Ann
     Ashley
      Arthur
      Austin
    David
     Charles
      Betty
       Benjamin
       Carol
        Brian
         Brenda
          Brandon
           Billy
            Beverly
            Bobby
         Carl
          Bryan
           Bruce
            Brittany
        Catherine
         Carolyn
      Christopher
       Christine
        Christina
         Cheryl
          Christian
       Daniel
        Cynthia
        Danielle
     Dorothy
      Donald
       Deborah
        Debra
         Dennis
          Denise
          Diane
           Diana
       Donna
        Doris
      Edward
       Douglas
        Dylan
   George
    Emily
     Gary
      Eric
       Emma
       Frank
        Evelyn
         Ethan
          Eugene
         Frances
        Gabriel
    Helen
     Gregory
      Gerald
       Gloria
        Grace
      Heather
       Harold
        Hannah
        Harry
     Jacob
      Jack
       Henry
      Jacqueline
  John
   Jennifer
    Jason
     Janet
      Jane
      Janice
     Jeffrey
      Jean
    Jessica
     Jerry
      Jeremy
      Jesse
     Joan
      Joe
   Linda
    Joseph
     Jonathan
      Johnny
      Jose
       Jordan
     Karen
      Joshua
       Justin
        Julie
         Joyce
          Judith
           Juan
           Julia
            Judy
      Kimberly
       Kenneth
        Kathleen
         Katherine
         Kelly
          Keith
           Kathryn
            Kayla
        Kevin
       Laura
        Larry
         Kyle
        Lauren
         Lawrence
    Margaret
     Lisa
      Madison
       Louis
        Lori
         Logan
     Mark
      Maria
       Marie
        Marilyn
      Martha
 Patricia
  Michael
   Matthew
    Melissa
     Megan
   Nancy
    Michelle
    Nicholas
     Nathan
      Natalie
     Pamela
      Nicole
       Olivia
        Noah
  Robert
   Richard
    Paul
     Patrick
     Rebecca
      Raymond
       Rachel
        Peter
         Philip
        Ralph
         Randy
   William
    Susan
     Sarah
      Sandra
       Ronald
        Roger
        Ryan
         Ruth
          Roy
           Rose
           Russell
         Samantha
          Samuel
       Sara
      Steven
       Stephanie
        Sharon
         Scott
          Sean
         Shirley
        Stephen
     Thomas
      Terry
       Teresa
       Theresa
      Timothy
       Tiffany
       Virginia
        Tyler
         Victoria
          Vincent
        Walter
         Wayne
    Zachary
     Willie
ENDOUT
