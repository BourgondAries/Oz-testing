functor
import
	Application
	Browser
	System
define

	\insert List.oz

	fun {GetMain State}
		case State of state(main:X ...) then
			X
		else nil end
	end

	fun {GetA State}
		case State of state(trackA:X ...) then
			X
		else nil end
	end

	fun {GetB State}
		case State of state(trackB:X ...) then
			X
		else nil end
	end

	fun {ApplyMoves State Moves}
		case Moves of Move|RemainingMoves then
			local NewState
				NewState = {ApplyMoves State Move}
			in
				case RemainingMoves of Mv|Rm then
					State|{ApplyMoves NewState RemainingMoves}
				else
					State|NewState|{ApplyMoves NewState RemainingMoves}
				end
			end
		[] trackA(N) then
			if N>0 then
				local A X L Y T Z B
					A = {GetA State}
					X = {GetMain State}
					L = {Length X}
					Y = {Drop X L-N}
					T = {Append Y A}
					Z = {Take X L-N}
					B = {GetB State}
				in
					state(main:Z trackA:T trackB:B)
				end
			elseif N<0 then
				local
					A = {GetA State}
					X = {GetMain State}
					L = {Length X}
					NewA = {Drop A ~N}
					MovedA = {Take A ~N}
					Z = {Append X MovedA}
					B = {GetB State}
				in
					state(main:Z trackA:NewA trackB:B)
				end
			else nil end
		[] trackB(N) then
			if N>0 then
				local A X L Y T Z B
					A = {GetB State}
					X = {GetMain State}
					L = {Length X}
					Y = {Drop X L-N}
					T = {Append Y A}
					Z = {Take X L-N}
					B = {GetA State}
				in
					state(main:Z trackA:B trackB:T)
				end
			elseif N<0 then
				local
					A = {GetA State}
					X = {GetMain State}
					L = {Length X}
					NewB = {Drop B ~N}
					MovedA = {Take A ~N}
					Z = {Append X MovedA}
					B = {GetB State}
				in
					state(main:Z trackA:A trackB:NewB)
				end
			else nil end
		else nil end
	end

	proc {PrintList List}
		case List of X|Xs then
			{System.showInfo X}
			{PrintList Xs}
		else skip end
	end

	proc {PrintState State}
		local
			A = {GetA State}
			B = {GetB State}
			X = {GetMain State}
		in
			{System.showInfo "main:"}
			if {Length X} > 0 then {PrintList X} end
			{System.showInfo "trackA:"}
			if {Length A} > 0 then {PrintList A} end
			{System.showInfo "trackB:"}
			if {Length B} > 0 then {PrintList B} end
		end
	end

	proc {PrintStatesN StateList N}
		case StateList of State|List then
			{System.showInfo "State number"}
			{System.showInfo N}
			{PrintState State}
			{PrintStatesN List N+1}
		else skip end
	end

	proc {PrintStates StateList}
		{PrintStatesN StateList 1}
	end

	local
		State = state(main:[a b] trackA:nil trackB:nil)
		Mvs = [trackA(1) trackA(~1)]
		NewStateList = {ApplyMoves State Mvs}
	in
		{System.showInfo {Length NewStateList}}
		{PrintStates NewStateList}
	end
	{Application.exit 0}
	{System.showInfo {Length [1 2 4 5 6]}}
	{System.showInfo {Position [1 2 4 5 6] 4}}
	{System.showInfo {Nth {Take [1 2 4 5 6] 4} 3}}
	{System.showInfo {Nth {Drop [1 2 4 5 6] 3} 2}}
	{System.showInfo {Nth {Append [1 2 4 5 6] [8 9]} 5}}
	if {Member [1 2 3 4 5 6] 1} then
		{System.showInfo "Inside"}
	end
	{Application.exit 0}

	fun {Factorial Number}
		if Number == 0 then 1
		else Number * {Factorial Number - 1} end
	end

	proc {PrintLines NumberOfLines}
		if NumberOfLines == 0 then skip
		else
			{System.showInfo 'woot'}
			{PrintLines NumberOfLines - 1}
		end
	end

	%% Declare an anonymous procedure
	Max = proc {$ X Y Z}
		if X >= Y then Z = X
		else Z = Y end
	end

	local A in
		{Max 1 2 A}
		{System.showInfo A}
	end

	proc {Do A}
		case A of 3 then {System.showInfo 'three'}
		[] 2 then {System.showInfo 'two'}
		[] 1 then {System.showInfo 'one'}
		else {System.showInfo 'none'} end
	end

	{Do 4}
	{Do 2}

	fun {Generate N}
		case N of 0 then nil
		else N|{Generate N-1}
		end
	end

	fun {Sumi L A}
		case L of nil then A
		[] X|Xs then {Sumi Xs A+X}
		end
	end

	{System.showInfo {Sumi {Generate 121389} 0}}
	{ForAll {Generate 120} proc {$ Item} {System.showInfo Item} end}

	%% Let's create a small URL parser
	{ForAll "Damn son where'd you find this" proc {$ C} {System.showInfo C} end}

	local
		R = record(x: hello)
		fun {GetX record(x:X ...)} X end
	in
		{System.showInfo {GetX R}}
	end

	local X = [f a b c d] in
		{System.showInfo {Nth {Reverse X} 2}}
		{System.showInfo X.2.2.1}
		{System.showInfo {Nth {Append X X} 6}}
		{System.showInfo {Nth {Sort X fun {$ X Y} X < Y end} 1}}
	end

	local
		fun {Matches X C}
			case X of Y|Ys then
				case C of Z|Zs then
					if Y == Z then {Matches Ys Zs}
					else ~1 end
				end
			end
		end
		fun {Find X C O}
			case X of Xi|Xs then
				if Xi == C then O
				else {Find Xs C O+1} end
			else O end
		end
	in
		{System.showInfo {Find "Hey:Ho" ":H" 0}}
		{System.showInfo {Matches "Hey:Ho" ":H"}}
	end

	local X in
		{NewName X}
	end

	local X = [1 2 3 4] in
		{System.showInfo {Nth X 3}}
	end

	%% {For 1 20 1 proc {$ I} {System.showInfo I} end}

	%% thread {PrintLines 10} end
	%% thread {System.showInfo {Factorial 100}} end

	%% {Application.exit 0}
end
