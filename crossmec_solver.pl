%% valid_row(R, Pos, Colors)
%% Generate a valid* distribution of colors for the cells in row R.
%% R: Number of the row.
%% Pos: Position of the next cell to paint in the row.
%% Colors: List of tuples (Color, Count) representing the valid layout for cells beginning from Pos.

valid_row(R, Pos, []) :- !.

valid_row(R, Pos, [(Color, Count) | Colors]) :-
    set_group(R, Pos, Color, Count), 
    Next is Pos + Count, 
    valid_row(R, Next, Colors).

valid_row(R, Pos, Colors) :-
    cell(R, Pos, _), %% fail if there are colors but no more cells
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
    retract(cell(R, Pos, _)), 
    assert(cell(R, Pos, Color)), 
    Next is Pos + 1, Remaining is Count - 1, 
    set_group(R, Next, Color, Remaining).

set_group(R, Pos, Color, Count) :- %% there was a failure, clean cell
    retract(cell(R, Pos, _)), 
    assert(cell(R, Pos, empty)), 
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


%% valid_column(C, Pos, Colors)
%% Check if cells in the column C follow a valid layout.
%% C: Number of the column to validate.
%% Pos: Position of the next cell to check in the column.
%% Colors: List of tuples (Color, Count) representing the valid layout for cells beginning from Pos.

valid_column(C, Pos, []) :- 
    not(cell(Pos, C, _)), !. %% no more colors and no more cells

valid_column(C, Pos, Colors) :- 
    cell(Pos, C, empty), !,
    Next is Pos + 1, 
    valid_column(C, Next, Colors).

valid_column(C, Pos, [(Color, Count) | Colors]) :- 
    valid_group(C, Pos, Color, Count), 
    Next is Pos + Count, 
    valid_column(C, Next, Colors).


%% valid_group(C, Pos, Color, Count)
%% Check if there is an adjacent group of cells in a column with the same color
%% C: Number of the column.
%% Pos: Position of the next cell to check in the group.
%% Color: Color all cells in the group must have.
%% Count: Amount of cells in the group.

valid_group(_, _, _, 0) :- !.

valid_group(C, Pos, Color, Count) :- 
    cell(Pos, C, Color), 
    Next is Pos + 1, Remaining is Count - 1, 
    valid_group(C, Next, Color, Remaining).


%% valid(C)
%% Check if all columns starting from C are valid.
%% C: Next column to check.

valid(C) :- 
    column(C, Colors), !, 
    valid_column(C, 0, Colors),
    Next is C + 1, 
    valid(Next).

valid(C).


%% solve
%% Generate valid rows and check them.

solve :- fill_board(0), valid(0).


%%% USER INTERFACE

%% solve(Rows, Columns, Board)
%% Solve a game represented by the layouts of rows and columns.
%% Rows: List of Lists of tuples (Color, Count) representing the rows layout.
%% Columns: Lists of Lists of tuples (Color, Count) representing the colums layout.
%% Board: List of Lists of colors (each List corresponding to a row); representing a valid solution.

solve(Rows, Columns, Board) :- 
    store_info(0, row, Rows), 
    store_info(0, column, Columns), 
    store_cells(0, 0), 
    solve, 
    load_board(0, Board),
    clean.


%% store_info(Pos, Type, Layout)
%% Store the information of a row/column layout in the database.
%% Pos: Number of the row/column.
%% Type: row if it's a row, column if it's a column.
%% Layout: Layout of the row/column.

store_info(_, _, []).

store_info(Pos, Type, [Colors | L]) :- 
    Fact =..[Type, Pos, Colors], 
    assert(Fact), 
    Next is Pos + 1, 
    store_info(Next, Type, L).


%% store_cells(R, C)
%% Store in the database, as empty, cells beginning from (R, C), upside down.
%% R: Vertical position of the next cell to store.
%% C: Horizontal position of the next cell to store.

store_cells(R, C) :- not(row(R, _)), !. %% no more cells

store_cells(R, C) :- 
    not(column(C, _)), !, %% row end, go to the next one
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

clean :- clean(row, 2), clean(column, 2), clean(cell, 3).


%% clean(Type, Count)
%% Clean all information of a specific kind from the database.
%% Type: Name of the predicate.
%% Count: Arity of the predicate.

clean(Type, Count) :-
    functor(Fact, Type, Count),
    retract(Fact), !,
    clean(Type, Count).

clean(_, _).


%% *(1) it's not completely valid since groups of the same color might be put together, but those cases will fail when checking the columns...
%%      assuming the answer is unique.