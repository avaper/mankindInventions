% 2 o más constantes
antigua.
medieval.
moderna.
contemporanea.
ac.
dc.

% 2 o más hechos con variables y 2 o más sin variables.

invento('Tornillo de Arquimedes',   'Arquimedes',            	-700).
invento('Imprenta',                 'Johannes Gutenberg',    	1450).
invento('Telescopio',               'Galileo Galilei',       	1608).
invento('Telefono',                 'Alexander Graham Bell',	1876).

% 5 o más predicados;

	% Al menos un ejemplo de uso de uno de los operadores aritméticos o relacionales predefinidos. 

epoca(X, Y) 	  :- X <   475, Y = antigua.
epoca(X, Y) 	  :- X >=  476, X =< 1492, Y = medieval.
epoca(X, Y) 	  :- X >= 1493, X =< 1789, Y = moderna.
epoca(X, Y)		  :- X >  1790, Y = contemporanea.

calendario(X, Y)  :- X < 0, Y = ac.	   
calendario(X, Y)  :- X > 0, Y = dc.	   

	% La satisfacción de 2 o más objetivos habrá de requerir el encadenamiento de 2 o más reglas.
	% 2 o más reglas deberán constar de 2 o más antecedentes y 											
								
menu :- nl, write('Menu:'), nl,
		write('\t1. Insertar invento'), nl, 
		write('\t2. Borrar invento'), nl, 
		write('\t3. Borrar todos los inventos'), nl, 
		write('\t4. Mostrar todos los inventos'), nl,
		write('\t5. Comprobar epoca de un invento'), nl,
		write('\t6. Preguntar por el inventor de...'), nl,
		write('\t7. Preguntar fecha de invencion de...'), nl, 
		write('\t8. Preguntar por el invento de...'), nl, nl, 
		write('Selecciona una opcion (0 para salir) '), read(Opcion), nl,
		ejecutar(Opcion).
		
		% Al menos uno de los predicados habrá de definirse mediante 2 o más reglas, 
		
ejecutar(Opcion) :- Opcion == 1, insertar, menu;
					Opcion == 2, eliminar, menu;
					Opcion == 3, borrar, menu;
					Opcion == 4, listar, menu;
					Opcion == 5, epoca, menu;
					Opcion == 6, averiguaInventor, menu;
					Opcion == 7, averiguaAnnio, menu;
					Opcion == 8, averiguaInvento, menu;
					Opcion == 0, true.
					
		% Al menos un ejemplo de uso de los predicados de inserción y borrado de hechos de la Base de Hechos.
					
:- dynamic(invento/3).
					
insertar :- write('Escribe el nombre del invento '), read(Invento),
			write('Escribe el nombre del inventor '), read(Inventor),
			write('Escribe la fecha de invencion '), read(Annio),
			Inve = invento(Invento, Inventor, Annio),
			assert(Inve).

eliminar :- write('Escribe el nombre del invento '), read(Nombre), nl,
			retract(invento(Nombre, _, _)),
			write('Se ha borrado el invento '), write(Nombre), nl, !.
eliminar :- write('No se conoce tal invento'), nl.

borrar :- retractall(invento(_, _, _)),
		  write('Se han borrado todos los inventos '), nl.
		  
listar :- findall([Invento, Inventor, Annio], invento(Invento, Inventor, Annio), ListaInventos), 
				   muestraInventos(ListaInventos).
listar :- write('No se conoce ningun invento').
				   
	% Al menos un ejemplo de recursividad. 
			 
muestraInventos([]) :- !.
muestraInventos([Invento|ListaInventos]) :- imprime(Invento), nl,
									  muestraInventos(ListaInventos).
									  
imprime([Invento|[Inventor, Annio]]) :- write("Invento:\t"), write(Invento), nl, 
									    write("Inventor:\t"), write(Inventor), nl, 
										write("Annio:\t\t"), write(Annio), write(" "),
										calendario(Annio, L), write(L), nl.

	% Al menos uno de los predicados deberá tener 2 o más argumentos
	
epoca :- write('Escribe el nombre del invento'), read(Inv), nl, 
		 invento(Inv, _, X), epoca(X, L), write('La epoca del invento es la '), write(L), nl.
epoca :- write('Invento desconocido').

averiguaInventor :- write('Escribe el nombre del invento '), read(Invento), nl, 
					dameInventor(Invento, Inventor), write(Inventor), nl.
averiguaInventor :- write('Invento desconocido'), nl.	
dameInventor(Invento, Inventor) :- Inventor = N, invento(Invento, N, _).

averiguaAnnio    :- write('Escribe el nombre del invento '), read(Invento), nl, 
				    dameAnnio(Invento, Annio), write(Annio), nl.
averiguaAnnio    :- write('Invento desconocido'), nl.
dameAnnio(Invento, Annio)       :- Annio    = N, invento(Invento, _, N).

averiguaInvento  :- write('Escribe el nombre del inventor '), read(Inventor), nl, 
				    dameInvento(Inventor, Invento), write(Invento), nl.
averiguaInvento  :- write('Inventor desconocido'), nl.			
dameInvento(Inventor, Invento)  :- Invento  = N, invento(N, Inventor, _).