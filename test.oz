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
					B = {GetB State}
					NewB = {Drop B ~N}
					MovedA = {Take B ~N}
					Z = {Append X MovedA}
				in
					state(main:Z trackA:A trackB:NewB)
				end
			else nil end
		else nil end
	end

	fun {SplitTrain Xs Y}
		local
			Pos = {Position Xs Y}
			Hs = {Take Xs Pos-1}
			Ts = {Drop Xs Pos}
			Head = if {Length Hs} > 0 then Hs else [nil] end
			Tail = if {Length Ts} > 0 then Ts else [nil] end
		in
			Head|Tail
		end
	end

	fun {FindCar Xs Ys}
		case Xs of nil then nil
		[] X|Xt then
			case Ys of Y|Yz then
				if Ys==Xs then
					{FindCar Xt Yz}
				else
					local
						A = {SplitTrain Xs Y}
						AfterY = {Nth A 2}
						BeforeY = {Nth A 1}
						YWithAfterYCount = {Length AfterY}+1
						BeforeYCount = {Length BeforeY}
						NewState = AfterY|BeforeY
					in
						trackA(YWithAfterYCount)|trackB(BeforeYCount)|trackA(~YWithAfterYCount)|trackB(~BeforeYCount)|{FindCar NewState Yz}
					end
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
		State = state(main:[a b] trackA:[c] trackB:nil)
		Mvs = [trackA(1) trackA(~1) trackB(1) trackB(1) trackB(~2) trackA(2) trackA(~3)]
		NewStateList = {ApplyMoves State Mvs}
	in
		{System.showInfo {Length NewStateList}}
		{PrintStates NewStateList}
	end
	{System.showInfo {Length {Nth {SplitTrain [1 2 3 4] 1} 2}}}
	local
		B = {SplitTrain [a b] b}
		{System.showInfo {Nth {Nth B 1} 1}}
		A = {FindCar [a b] [b a]}
	in
		{System.showInfo {Length A}}
		{System.showInfo {Nth A 6}}
	end
	{Application.exit 0}

end
