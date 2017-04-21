row(0, [(blue, 5)]).

column(0, [(blue, 1)]).
column(1, [(blue, 1)]).
column(2, [(blue, 1)]).
column(3, [(blue, 1)]).
column(4, [(blue, 1)]).

prepare :- assert(cell(0, 0, empty)),
			assert(cell(0, 1, empty)),			
			assert(cell(0, 2, empty)),
			assert(cell(0, 3, empty)),
			assert(cell(0, 4, empty)).