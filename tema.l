/* Sima Nicoleta-Lavinia 334CC */
%{
	#include <stdio.h>
	int i;
	int imbricare = 0;
%}

cuvant [a-zA-Z0-9]
link [a-zA-Z0-9 ,*%#/:.;-]
begin_ignore1 "<!"
begin_ignore2 "<?"
end_ignore ">"
start_tag "<"

%x IGNORE LONG_TAG VALUE TAG

%%
	/*starea in care am gasit comentariu, inceput de fisier sau*/
	/*ceea ce se afla intre 2 tag-uri, se ignora tot pana se gaseste tag-ul de sfarsit*/

<INITIAL>{begin_ignore1}|{begin_ignore2} {BEGIN(IGNORE);}
<IGNORE>{end_ignore} {BEGIN(INITIAL);}
<IGNORE>{start_tag} {BEGIN(TAG);}
<IGNORE>.|\n {}
	
	/* inceput de tag */
<INITIAL>"<" {
	BEGIN(TAG);
}

	/* afisez numele tag-ului */
<TAG>{cuvant}+ {
	for (i = 0; i < imbricare; i++) {
		printf(" ");
	}
	imbricare++;
	printf("%s", yytext);
}

	/* tag de tipul <br/> */
<TAG>" />"|"/>" {
	printf("\n");
	imbricare--;
	BEGIN(IGNORE);
}
	/* daca numele tag-ului exista spatiu inseamna ca */
	/* va avea perechi de tipul atribut=valoare */
<TAG>" " {
	printf(" ::  ");
	BEGIN(LONG_TAG);
}

	/* se inchide tag-ul si se ignora orice este dupa el*/
	/* in afara de alt tag */
<TAG>">" {
	printf("\n");
	BEGIN(IGNORE);
}

	/* simbolul semnifica inceputul unui tag de incheiere */
<TAG>"/" {
	imbricare--;
	BEGIN(IGNORE);
}

	/* atribut= */
<LONG_TAG>{cuvant}+"="|{cuvant}+" = " {
	REJECT;
}

	/* se ia doar numele atributului */
<LONG_TAG>{cuvant}+ {
	printf("%s", yytext);
}
	
	/* daca am gasit egal inseamna ca urmeaza o valoare */
	/* care trebuie afisata */
<LONG_TAG>"=""\""|" = ""\""|"= ""\"" {
	if (yytext[yyleng - 2] == ' ')
		printf(": ");
	else {
		printf(" : ");
	}
	BEGIN(VALUE);
}

<LONG_TAG>">" {
	printf("\n");
	BEGIN(INITIAL);
}

<LONG_TAG>"/>" {
	printf("\n");
	imbricare--;
	BEGIN(INITIAL);
}
	/* face match pe valoarea in starea VALUE */
<VALUE>{link}+ {
	printf("%s ; ", yytext);
}
	
	/* ghilimele indica ca am gasit valoarea si continua analiza*/
<VALUE>"\" "|"\"" {
	printf(" ");
	BEGIN(LONG_TAG);
}

.|\n {}
%%

int yywrap(){} 

int main(int argc, char **argv)
{
	yyin = fopen(argv[1], "r");
	if (!yyin) {
		printf("eroare");
	}
	yylex();
	return 0;
}