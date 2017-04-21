row(0, [(blue, 5)]).
row(1, [(green, 5)]).

column(0, [(blue, 1), (green, 1)]).
column(1, [(blue, 1), (green, 1)]).
column(2, [(blue, 1), (green, 1)]).
column(3, [(blue, 1), (green, 1)]).
column(4, [(blue, 1), (green, 1)]).

prepare :- assert(cell(0, 0, empty)),
			assert(cell(0, 1, empty)),			
			assert(cell(0, 2, empty)),
			assert(cell(0, 3, empty)),
			assert(cell(0, 4, empty)),
			assert(cell(1, 0, empty)),
			assert(cell(1, 1, empty)),			
			assert(cell(1, 2, empty)),
			assert(cell(1, 3, empty)),
			assert(cell(1, 4, empty)).