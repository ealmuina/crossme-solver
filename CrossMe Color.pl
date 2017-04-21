valid_row(R, Pos, []) :- !.

valid_row(R, Pos, [(Color, Count) | Colors]) :- set_row(R, Pos, Color, Count), 
                                                Next is Pos + Count, valid_row(R, Next, Colors).

valid_row(R, Pos, Colors) :- cell(R, Pos, _), Next is Pos + 1, valid_row(R, Next, Colors).


set_row(_, _, _, 0) :- !.

set_row(R, Pos, Color, Count) :- retract(cell(R, Pos, _)), assert(cell(R, Pos, Color)), 
                                 Next is Pos + 1, Remaining is Count - 1, set_row(R, Next, Color, Remaining).

set_row(R, Pos, Color, Count) :- retract(cell(R, Pos, _)), assert(cell(R, Pos, empty)), fail.


fill_board(R) :- row(R, Colors), !, valid_row(R, 0, Colors), 
                 Next is R + 1, fill_board(Next).

fill_board(R).


valid_column(C, Pos, []) :- not(cell(Pos, C, _)), !.

valid_column(C, Pos, Colors) :- cell(Pos, C, empty), !,
                                Next is Pos + 1, valid_column(C, Next, Colors).

valid_column(C, Pos, [(Color, Count) | Colors]) :- valid_group(C, Pos, Color, Count), 
                                                   Next is Pos + Count, valid_column(C, Next, Colors).


valid_group(_, _, _, 0) :- !.

valid_group(C, Pos, Color, Count) :- cell(Pos, C, Color), 
                                     Next is Pos + 1, Remaining is Count - 1, valid_group(C, Next, Color, Remaining).


valid(C) :- column(C, Colors), !, valid_column(C, 0, Colors),
            Next is C + 1, valid(Next).

valid(C).


solve :- fill_board(0), valid(0).


%%% USER INTERFACE 

solve(Rows, Columns, Board) :- store_info(0, row, Rows), store_info(0, column, Columns), store_cells(0, 0), 
                               solve, load_board(0, Board).


store_info(_, _, []).

store_info(Pos, Type, [Colors | L]) :- Fact =..[Type, Pos, Colors], assert(Fact), 
                                       Next is Pos + 1, store_info(Next, Type, L).


store_cells(R, C) :- not(row(R, _)), !.

store_cells(R, C) :- not(column(C, _)), !, Next is R + 1, store_cells(Next, 0).

store_cells(R, C) :- assert(cell(R, C, empty)), Next is C + 1, store_cells(R, Next).


load_board(Pos, []) :- not(row(Pos, _)), !.

load_board(Pos, [Row | Board]) :- setof((Pos, C, Color), cell(Pos, C, Color), Row_full), just_color(Row_full, Row),
                                  Next is Pos + 1, load_board(Next, Board).


just_color([], []).

just_color([(Pos, C, Color) | Row_full], [Color | Row]) :- just_color(Row_full, Row).
