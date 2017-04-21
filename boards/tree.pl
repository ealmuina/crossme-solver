row(0, [(green, 3)]).
row(1, [(green, 5)]).
row(2, [(green, 5)]).
row(3, [(green, 2), (brown, 1), (green, 2)]).
row(4, [(brown, 1)]).

column(0, [(green, 3)]).
column(1, [(green, 4)]).
column(2, [(green, 3), (brown, 2)]).
column(3, [(green, 4)]).
column(4, [(green, 3)]).

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
			assert(cell(4, 4, empty)).