row(0, [(red, 2), (red, 2)]).
row(1, [(red, 5)]).
row(2, [(red, 1), (yellow, 1), (red, 1)]).
row(3, [(red, 5)]).
row(4, [(red, 2), (green, 1), (red, 2)]).
row(5, [(green, 1)]).
row(6, [(green, 1), (green, 1)]).
row(7, [(green, 1), (green, 3)]).
row(8, [(green, 4)]).
row(9, [(green, 2)]).

column(0, [(red, 2), (red, 2), (green, 2)]).
column(1, [(red, 5), (green, 2)]).
column(2, [(red, 1), (yellow, 1), (red, 1), (green, 6)]).
column(3, [(red, 5), (green, 2)]).
column(4, [(red, 2), (red, 2), (green, 2)]).

prepare :- assert(cell(0, 0, empty)),
			assert(cell(0, 1, empty)),			
			assert(cell(0, 2, empty)),
			assert(cell(0, 3, empty)),
			assert(cell(0, 4, empty)),
			assert(cell(1, 0, empty)),
			assert(cell(1, 1, empty)),			
			assert(cell(1, 2, empty)),
			assert(cell(1, 3, empty)),
			assert(cell(1, 4, empty)),
			assert(cell(2, 0, empty)),
			assert(cell(2, 1, empty)),			
			assert(cell(2, 2, empty)),
			assert(cell(2, 3, empty)),
			assert(cell(2, 4, empty)),
			assert(cell(3, 0, empty)),
			assert(cell(3, 1, empty)),			
			assert(cell(3, 2, empty)),
			assert(cell(3, 3, empty)),
			assert(cell(3, 4, empty)),
			assert(cell(4, 0, empty)),
			assert(cell(4, 1, empty)),			
			assert(cell(4, 2, empty)),
			assert(cell(4, 3, empty)),
			assert(cell(4, 4, empty)),
			assert(cell(5, 0, empty)),
			assert(cell(5, 1, empty)),			
			assert(cell(5, 2, empty)),
			assert(cell(5, 3, empty)),
			assert(cell(5, 4, empty)),
			assert(cell(6, 0, empty)),
			assert(cell(6, 1, empty)),			
			assert(cell(6, 2, empty)),
			assert(cell(6, 3, empty)),
			assert(cell(6, 4, empty)),
			assert(cell(7, 0, empty)),
			assert(cell(7, 1, empty)),			
			assert(cell(7, 2, empty)),
			assert(cell(7, 3, empty)),
			assert(cell(7, 4, empty)),
			assert(cell(8, 0, empty)),
			assert(cell(8, 1, empty)),			
			assert(cell(8, 2, empty)),
			assert(cell(8, 3, empty)),
			assert(cell(8, 4, empty)),
			assert(cell(9, 0, empty)),
			assert(cell(9, 1, empty)),			
			assert(cell(9, 2, empty)),
			assert(cell(9, 3, empty)),
			assert(cell(9, 4, empty)).