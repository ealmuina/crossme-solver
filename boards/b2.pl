row(0, [(blue, 5)]).
row(1, [(blue, 5)]).

column(0, [(blue, 2)]).
column(1, [(blue, 2)]).
column(2, [(blue, 2)]).
column(3, [(blue, 2)]).
column(4, [(blue, 2)]).

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