%% valid_row(R, Pos, Colors)
%% Generate a valid distribution of colors for the cells in row R.
%% R: Number of the row.
%% Pos: Position of the next cell to paint in the row.
%% Colors: List of tuples (Color, Count) representing the valid layout for cells beginning from Pos.

valid_row(R, Pos, []) :- !.

valid_row(R, Pos, [(Color, Count) | Colors]) :-
    Previous is Pos - 1,
    not(cell(R, Previous, Color)), %% there can't be two consecutive groups with the same color
    set_group(R, Pos, Color, Count), 
    Next is Pos + Count, 
    valid_row(R, Next, Colors).

valid_row(R, Pos, Colors) :-
    cell(R, Pos, _), %% fail if there are colors but no more cells
    valid_column(Pos, R, empty),
    Next is Pos + 1, 
    valid_row(R, Next, Colors).


%% set_group(R, Pos, Color, Count)
%% Paint a group of adjacent cells in a row with the same color.
%% R: Number of the row.
%% Pos: Position of the next cell to paint in the group.
%% Color: Color to paint the cells.
%% Count: Amount of cells in the group.

set_group(_, _, _, 0) :- !.

set_group(R, Pos, Color, Count) :- 
    valid_column(Pos, R, Color),
    set_cell(R, Pos, Color),
    Next is Pos + 1, Remaining is Count - 1, 
    set_group(R, Next, Color, Remaining).


set_cell(R, C, Color) :-
    retract(cell(R, C, _)), 
    assert(cell(R, C, Color)).

set_cell(R, C, Color) :- %% there was a failure, clean cell
    retract(cell(R, C, _)), 
    assert(cell(R, C, empty)), 
    fail. %% and fail again


%% fill_board(R)
%% Generate valid rows starting from R.
%% R: Number of the next row to generate.

fill_board(R) :- 
    row(R, Colors), !, 
    valid_row(R, 0, Colors), 
    Next is R + 1, 
    fill_board(Next).

fill_board(R).


valid_column(C, Pos, empty) :- !, column(C, [empty | _], _).

valid_column(C, Pos, Color) :- 
    column(C, [empty, Color | _], _), !,
    Previous is Pos - 1,
    not(cell(Previous, C, Color)), %% there can't be two consecutive groups with the same color
    update_column(C, empty),
    update_column(C, Color).

valid_column(C, Pos, Color) :-
    column(C, [Color | _], _),
    update_column(C, Color).


update_column(C, Color) :-
    retract(column(C, [Color | RColors], Colors)),
    assert(column(C, RColors, [Color | Colors])).

update_column(C, Color) :-
    retract(column(C, RColors, [Color | Colors])),
    assert(column(C, [Color | RColors], Colors)),
    fail.


%% solve
%% Generate valid rows and check them.

solve :- fill_board(0).


%%% USER INTERFACE

%% solve(Rows, Columns, Board)
%% Solve a game represented by the layouts of rows and columns.
%% Rows: List of Lists of tuples (Color, Count) representing the rows layout.
%% Columns: Lists of Lists of tuples (Color, Count) representing the colums layout.
%% Board: List of Lists of colors (each List corresponding to a row); representing a valid solution.

solve(Rows, Columns, Board) :- 
    store_row(0, Rows), 
    store_columns(0, Columns), 
    store_cells(0, 0), 
    solve, 
    load_board(0, Board).

store_columns(_, []).

store_columns(C, [Colors | Columns]) :-
    expand_column(Colors, EColors),
    assert(column(C, [empty | EColors], [])),
    Next is C + 1,
    store_columns(Next, Columns).


expand_column([], []).

expand_column([(_, 0) | Colors], [empty | EColors]) :- !, expand_column(Colors, EColors).

expand_column([(Color, Count) | Colors], [Color | EColors]) :-
    Remaining is Count - 1,
    expand_column([(Color, Remaining) | Colors], EColors).


store_row(_, []).

store_row(R, [Colors | L]) :- 
    assert(row(R, Colors)), 
    Next is R + 1, 
    store_row(Next, L).


%% store_cells(R, C)
%% Store in the database, as empty, cells beginning from (R, C), upside down.
%% R: Vertical position of the next cell to store.
%% C: Horizontal position of the next cell to store.

store_cells(R, C) :- not(row(R, _)), !. %% no more cells

store_cells(R, C) :- 
    not(column(C, _, _)), !, %% row end, go to the next one
    Next is R + 1, 
    store_cells(Next, 0).

store_cells(R, C) :- 
    assert(cell(R, C, empty)), 
    Next is C + 1, 
    store_cells(R, Next).


%% load_board(Pos, Board)
%% Load colors of all rows beginning from Pos.
%% Pos: Next row to load.
%% Board: List of Lists of colors, with the result.

load_board(Pos, []) :- not(row(Pos, _)), !.

load_board(Pos, [Row | Board]) :- 
    setof((Pos, C, Color), cell(Pos, C, Color), Row_full), %% find all cells in the row, in order
    just_color(Row_full, Row), %% position of cells was just for sorting them
    Next is Pos + 1, 
    load_board(Next, Board).


%% just_color(Row_full, Row)
%% Remove information regarding to position from a List of tuples (Row, Column, Color).
%% Row_full: List of tuples (Row, Column, Color).
%% Row: List with the colors of Row_full items.

just_color([], []).

just_color([(Pos, C, Color) | Row_full], [Color | Row]) :- just_color(Row_full, Row).


%% clean
%% Clean all information regarding to the game from the database.

clean :- clean(row, 2), clean(column, 3), clean(cell, 3).


%% clean(Type, Count)
%% Clean all information of a specific kind from the database.
%% Type: Name of the predicate.
%% Count: Arity of the predicate.

clean(Type, Count) :-
    functor(Fact, Type, Count),
    retract(Fact), !,
    clean(Type, Count).

clean(_, _).


%% print_board(Board)
%% Print a board solution on console.
%% Board: List of Lists of colors representing a solution.

print_board([]).

print_board([Row | Board]) :-
    print_row(Row),
    print_board(Board).


%% print_row(Row)
%% Print a row of a board solution.
%% Row: List of colors representing a row of the solution.

print_row([]) :- format('~n').

print_row([empty | Row]) :- !,
    ansi_format(fg(default), '#', []),
    print_row(Row).

print_row([Color | Row]) :-
    ansi_format(fg(Color), '#', []),
    print_row(Row).

