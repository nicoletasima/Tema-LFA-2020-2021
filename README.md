Tema LFA 2020/2021
	Sima Nicoleta-Lavinia 334CC
	TEMA LFA - Varianta B

	Compilare: make
	Rulare: make runX, x <- [1:6] (primele 3 teste sunt testele propuse, iar
ultimele 3 sunt cele adaugate de mine pentru exemplificare)

	In cadrul temei am avut de parcurs un fisier XHTML corect din puncte de 
vedere sintactic din care am avut de extras elementele si atributele alaturi
de valorile acestora.
	Mi-am declarat variabile C necesare: contorul i si o variabila care
masoara nivelul de imbricare al elementelor.
	Pornesc din starea INITIAL si tratez prima data cazurile in care apar
comentarii sau elemente de la inceputul fisierului care nu trebuie sa fie 
afisate. Pentru cazurile in care se intalneste "<!" sau "<?" se intra in starea
de IGNORE si se ignora totul pana la intalnirea simbolului care indica sfarsitul
(">"). 
	Tratez apoi cazul in care intalnesc simbolul "<" care reprezinta
inceputul unui tag. In acest caz, trec in starea TAG si continui sa analiez
restul. Daca se intalneste un cuvant, acesta reprezinta numele tag-ului. Afisez
mai intai folosind un for nivelul sau de imbricare si apoi numele lui. De asemenea,
incrementez nivelul de imbricare pentru urmatoarele elemente. Decrementarea se face
la intalnirea simbolului care indica tag-ul de inchidere. In continuare voi lua
in considerare tag-urile mai speciale (<br/>) pentru care va trebui sa afisez in
plus newline. Daca dupa afisarea numelui, se afla simbolul ">" voi trece in starea
IGNORE pentru ca in continuare elementele nu vor fi afisate pana cand intalnesc "<",
caz ce indica inceputul unui nou tag si continui sa analizez ca pana acum.
Daca dupa afisarea numelui se afla spatiu, asta inseamna ca in continuare vor
fi de analizat elemente de tipul atribut=valoare si intru in starea LONG_TAG.
In aceasta noua stare voi lua in considerare prima data atributul care are atasat
simbolul "=". In acest caz, folosesc macroinstructiunea REJECT pentru reanalizare
si pentru a face math doar pe atribut pe care il si afisez. In cazul gasirii 
simbolului "\"" intru in starea VALUE care va analiza continutul valorii. La gasirea
ghilimelelor in aceasta stare ma intorc in starea LONG_TAG care va continua 
analizarea atributelor si valorilor pana la intalnirea ">" sau "/>" in functie
de caz. Am redefinit regula implicita pentru a trece peste newline-urile deja
existente in fisierul de intrare astfel incat sa pot avea control asupra 
afisarii.

	 
